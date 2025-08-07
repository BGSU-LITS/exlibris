(() => {
    // Work around searches to Summon that redirect to Library Search.
    const summon = window.location.hash.match(/(?:%3F|&)q=([^&]+)/);

    if (summon && typeof summon[1] !== 'undefined') {
        window.location = '/discovery/search?vid=' +
            window.appConfig.vid + '&query=any,contains,' + summon[1];
    }

    // Automatically perform search when a Search Profile Slot is selected.
    window.appConfig['primo-view']['attributes-map'].tabsRemote = 'true';

    // Load proactive chat script.
    const script = document.createElement('script');

    script.src = 'https://lib.bgsu.edu/template/2.0.0-b22/libchat.js';
    script.defer = true;

    script.addEventListener('load', () => {
        // After script has loaded, setup the proactive chat.
        bgsu_libchat.setup(
            'https://bgsu.libanswers.com/chat/widget/1d32264c0ea43602bbbbf36436c0d569',
            3057,
            [{d: [7259]}],
        );
    });

    document.head.appendChild(script);

    // Create Angular components to customize view.
    const app = angular.module('viewCustom', ['angularLoad']);

    // Add top bar to standalone login page.
    app.component('prmStandAloneLoginAfter', {
        template: `<prm-topbar></prm-topbar>`
    });

    // Do not open Main Menu links in new tabs/windows.
    // Move items by label to the user menu instead of main menu.
    app.component('prmTopNavBarLinksAfter', {
        controller($scope, $element, $compile) {
            this.$onInit = function() {
                const labels = [
                    'citationlinker',
                    'PurchaseRequest',
                    'PurchaseRequestForm',
                    'UserGuide'
                ];

                const menu = $scope.$parent.$ctrl.mainView;
                const move = [];

                let count = menu.length;

                while (count--) {
                    menu[count].target = '_self';

                    if (labels.includes(menu[count].label)) {
                        move.unshift(menu[count]);
                        menu.splice(count, 1);
                    }
                };

                const observe = $element[0].closest('prm-topbar');

                const observer = new MutationObserver(() => {
                    const element = observe.querySelector('.my-refworks-ctm');

                    if (element) {
                        move.forEach((item) => {
                            if (typeof(item.href) === 'undefined') {
                                item.href = item.url;

                                if (typeof(item.sref.params) !== 'undefined') {
                                    const params = new URLSearchParams(
                                        item.sref.params
                                    );

                                    item.href += '?' + params.toString();
                                }
                            }

                            const compiled = angular.element($compile(`
                                <md-menu-item class="menu-item-indented">
                                    <a class="md-button md-primoExplore-theme md-ink-ripple" role="menuitem"
                                        href="${item.href}" target="${item.target}">
                                        <span translate="${$scope.$parent.$ctrl.getMenuLabel(item)}"></span>
                                    </a>
                                </md-menu-item>
                            `)($scope));

                            element.parentElement.insertBefore(
                                compiled[0],
                                element
                            );
                        });

                        observer.disconnect();
                    }
                });

                observer.observe(observe, { childList: true, subtree: true });
            };
        },
    });

    // Show Search Profile Slots (Tabs and Scopes) by default in Search Bar.
    app.component('prmSearchBarAfter', {
        controller($scope) {
            this.$onInit = function() {
                $scope.$parent.$ctrl.showTabsAndScopes = true;
            };
        },
    });

    // Fix translation code for "Page" above search results not being displayed
    // because translation file hadn't loaded yet and isn't in cache.
    app.component('prmSearchResultListAfter', {
        controller($element) {
            this.$onInit = function() {
                const observe = $element[0].parentElement;

                const observer = new MutationObserver(() => {
                    const element = observe.querySelector(
                        '.mobile-page-range .text'
                    );

                    if (element) {
                        element.innerText = element.innerText.replace(
                            'nui.paging.pagenumber',
                            'Page'
                        );

                        observer.disconnect();
                    }
                });

                observer.observe(observe, { childList: true, subtree: true });
            };
        },
    });

    // Improve date range facet by selecting checkbox when changed.
    app.component('prmFacetRangeAfter', {
        controller($element) {
            this.$onInit = function() {
                const observe = $element[0].parentElement;

                const observer = new MutationObserver(() => {
                    const element = observe.querySelector('md-checkbox');

                    if (element) {
                        observe.querySelectorAll(
                            'input[type="number"]'
                        ).forEach((input) => input.addEventListener(
                            'change',
                            () => {
                                if (!element.hasAttribute('checked')) {
                                    element.click();
                                }
                            }
                        ));

                        observer.disconnect();
                    }
                });

                observer.observe(observe, { childList: true, subtree: true });
            };
        },
    });

    // Creates duplicates of Actions that call those actions.
    const callActions = {
        controller($element) {
            this.actions = [];

            this.callAction = function(action) {
                document.getElementById(action.button.id).click();
            };

            this.$onInit = function() {
                const list = $element[0].closest('prm-action-list');

                if (list) {
                    const els = list.querySelectorAll('.actions-names');

                    for (const el of els) {
                        this.actions.push({
                            parent: el,
                            button: el.querySelector('button'),
                            icon: el.querySelector('prm-icon'),
                            text: el.querySelector('.button-text'),
                        });
                    }
                }
            };
        },
        template: `
            <div class="call-actions">
                <button ng-repeat="action in $ctrl.actions" ng-click="$ctrl.callAction(action)" class="call-action call-action-{{action.parent.id}} {{action.button.className}} icon-button-with-text">
                    <div layout="column">
                        <prm-icon icon-type="{{action.icon.getAttribute('icon-type')}}" svg-icon-set="{{action.icon.getAttribute('svg-icon-set')}}" icon-definition="{{action.icon.getAttribute('icon-definition')}}"></prm-icon>
                        <span class="button-text">{{action.text.textContent}}</span>
                    </div>
                </button>
            </div>
        `,
    };

    // Add duplicates to the Citation and Permalink Actions.
    app.component('prmCitationAfter', callActions);
    app.component('prmPermalinkAfter', callActions);

    // Add full URL as param to Report a Problem links in Alma Viewit Items.
    app.component('prmAlmaViewitItemsAfter', {
        controller($scope) {
            this.$onInit = function() {
                // Specify links to modify, up through start of query.
                const pre = 'https://lib.bgsu.edu/problem/?';
                const url = encodeURIComponent(window.location.href);
                const services = $scope.$parent.$ctrl.services;

                for (let count = 0; count < services.length; count++) {
                    services[count].serviceUrl = services[count].serviceUrl.
                        replace(pre, pre + 'url=' + url + '&');
                }
            };
        },
    });

    // Add full URL as param to Report a Problem links in Links section.
    app.component('prmServiceLinksAfter', {
        controller($element) {
            this.$onInit = function() {
                const observe = $element[0].parentElement;

                const observer = new MutationObserver(() => {
                    const pre = 'https://lib.bgsu.edu/problem/?';
                    const url = encodeURIComponent(window.location.href);
                    const els = observe.querySelectorAll('a');

                    for (const el of els) {
                        el.href = el.href.replace(
                            pre,
                            pre + 'url=' + url + '&'
                        );
                    }
                });

                observer.observe(observe, { childList: true, subtree: true });
            };
        },
    });


    // Prevent clicks of items from toggling details to make selection easier.
    app.component('prmLocationItemAfter', {
        controller($element) {
            this.$onInit = function() {
                const observe = $element[0].parentElement;

                const observer = new MutationObserver(() => {
                    const element = observe.querySelector(
                        '.md-list-item-text'
                    );

                    if (element) {
                        element.addEventListener(
                            'click',
                            (event) => event.stopPropagation()
                        );

                        observer.disconnect();
                    }
                });

                observer.observe(observe, { childList: true, subtree: true });
            };
        },
    });

    // Collapse the Alma Other Members list by default.
    app.component('prmAlmaOtherMembersAfter', {
        controller($scope) {
            this.$onInit = function() {
                $scope.$parent.$ctrl.isCollapsed = true;
            };
        },
    });

    // Converts the time loans are due to a 12-hour clock.
    const fixLoanTime = {
        controller($element) {
            this.$onInit = function() {
                const observe = $element[0].parentElement;

                const observer = new MutationObserver(() => {
                    observe.querySelectorAll(
                        '.overdue-line,.overdue-line-overview span'
                    ).forEach(element => {
                        element.childNodes.forEach(node => {
                            if (node.nodeType === Node.TEXT_NODE) {
                                const find = /, (\d+):(\d+)/;
                                const matches = node.nodeValue.match(find);

                                if (matches) {
                                    node.nodeValue = node.nodeValue.replace(
                                        find,
                                        ' at ' + (matches[1] % 12 || 12) +
                                        ':' + matches[2] +
                                        ' ' + (matches[1] < 12 ? 'AM' : 'PM')
                                    );
                                }
                            }
                        });
                    });
                });

                observer.observe(observe, { childList: true, subtree: true });
            };
        },
    };

    // Convert time on both the loans overview and loan list in Library Account.
    app.component('prmLoansOverviewAfter', fixLoanTime);
    app.component('prmLoanAfter', fixLoanTime);

    // Add BGSU University Libraries header before Top Bar.
    app.component('prmTopBarBefore', {
        template: `
           <div class="bgsu-header">
                <a class="bgsu-header-logo" aria-label="BGSU" href="https://www.bgsu.edu/">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 392.4 110.16">
                        <symbol id="bgsu-logo">
                            <title>BGSU</title>
                            <path d="m28.8 44.2 14.69-.14c7.77 0 12.81-3 12.81-11 0-5.9-5-10.08-11.8-10.08H28.8V44.2m16.85 42.48c7.2 0 12.52-4.32 12.52-10.8 0-5.76-4-11.23-10.51-11.66H28.8v22.46ZM0 106.84V2.87h49.82c19.59.15 36 8.93 36 27.22 0 12.81-10.8 20.59-22.46 22.75v.29c13.82 1.87 25 10.66 25 25.49 0 30.24-38.59 28.22-39.6 28.22Z"></path>
                            <path d="M165.61 68h-21.16V47.8h50v55.58c-23.32 3.46-27.79 5.62-52.84 5.62-32.4-1-52.13-21.6-52.13-54.14S109.17 1.72 141.57.71c25.2-.72 51.69 3 52.12 33.27h-28.8c-1.44-10.08-9.36-13.11-18.89-13.11-19.44 0-26.35 17.14-26.35 34 0 20.44 10.22 34 31 34a77.35 77.35 0 0 0 15-1.73V68"></path>
                            <path d="M232.85 109c-16.56 0-30.52-12.1-31-29.23H212c.29 16 12.1 20.59 26.07 20.59 11.66 0 25-6.77 25-20 0-10.36-7.48-15.26-16.27-18.14-16.8-5.64-42.46-10.96-42.46-33.43 0-18.14 16.71-28.08 33.12-28.08 13.68 0 31.54 4.76 33.84 24.77h-10.08c-.29-12.81-12-16.13-22.61-16.13s-24.19 5.48-24.19 18.15c0 29.52 58.75 16.12 58.75 52 0 22.61-19.44 29.52-40.32 29.52"></path>
                            <path d="M293.38 2.87v67.25C294.1 89 304.9 100.36 322 100.36S350 89 350.69 70.12V2.87h9.36v67.39C359.77 92.58 347.24 109 322 109s-37.73-16.42-38-38.74V2.87h9.36"></path>
                            <path d="M384.25 93.71a8.41 8.41 0 0 1 0 11.84 8.31 8.31 0 0 1-11.81 0 8.41 8.41 0 0 1 0-11.85 8.21 8.21 0 0 1 11.86 0Zm1.25-1.29a9.73 9.73 0 0 0-7.16-3 9.93 9.93 0 0 0-7 2.75 9.65 9.65 0 0 0-3.17 7.38 10.13 10.13 0 1 0 17.29-7.16Zm-5.91 6.39a2.76 2.76 0 0 1-1.61.41h-1.13V96h.71a4.76 4.76 0 0 1 1.7.24 1.28 1.28 0 0 1 .91 1.28 1.51 1.51 0 0 1-.58 1.29Zm-2.74 2.43h.61l.65.05a3.13 3.13 0 0 1 1 .17 1.39 1.39 0 0 1 .83.83 5.18 5.18 0 0 1 .18 1.37 6.77 6.77 0 0 0 .18 1.55h2.8l-.1-.31a1.94 1.94 0 0 1-.07-.33 1.83 1.83 0 0 1 0-.33v-1a3 3 0 0 0-1-2.52 3.8 3.8 0 0 0-1.6-.64 3.77 3.77 0 0 0 1.95-.76 2.5 2.5 0 0 0 .79-2 2.83 2.83 0 0 0-1.5-2.68 5.55 5.55 0 0 0-2.21-.58L377 94h-3.1v11.22h3Z"></path>
                        </symbol>
                        <use xlink:href="#bgsu-logo"></use>
                    </svg>
                </a>
                <a class="bgsu-header-unit" href="https://www.bgsu.edu/library/">
                    <div>University Libraries</div>
                </a>
            </div>
        `,
    });

    // Add Ask Us! button after Search Bookmark Filter.
    app.component('prmSearchBookmarkFilterAfter', {
        template: `
            <a href="https://www.bgsu.edu/library/ask-us/" class="md-icon-button button-over-dark md-button md-primoExplore-theme md-ink-ripple">
                <md-tooltip>Ask Us!</md-tooltip>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 53 46">
                    <symbol id="bgsu-askus">
                        <path d="M1 15.93a10.39 10.39 0 01.7-3.43 15 15 0 013.92-5.95 19.4 19.4 0 016.66-4.11A20.99 20.99 0 0119.34 1a62.48 62.48 0 012.81.02 20.54 20.54 0 014.32.7 20.8 20.8 0 017.09 3.31 16.33 16.33 0 014.67 5.17 13.17 13.17 0 011.61 8.66 13.38 13.38 0 01-1.92 5.1 16.76 16.76 0 01-5.19 5.22 22.1 22.1 0 01-11.47 3.49 23.15 23.15 0 01-3.82-.19.47.47 0 00-.44.16 20.6 20.6 0 01-2.63 2.2 14.26 14.26 0 01-6.06 2.6 10.4 10.4 0 01-1.66.12.82.82 0 01-.55-.2.85.85 0 01-.05-1.18l.5-.58a12.51 12.51 0 002.42-5.7c.04-.24.04-.24-.16-.37l-.06-.03a17.64 17.64 0 01-5-4.5 12.36 12.36 0 01-2.5-5.46A32.4 32.4 0 011 15.93zm14.96-4.67l.2-.17a8.8 8.8 0 012.35-1.55 4.02 4.02 0 013.1-.1 3.05 3.05 0 011.76 1.5 2.04 2.04 0 01-.4 2.47 6.28 6.28 0 01-1.1.85l-1.4.88a7.2 7.2 0 00-1.3 1.05 3.77 3.77 0 00-1 1.73 10.48 10.48 0 00-.1 2.27c0 .06.03.09.09.09h3.92c.1.01.15-.03.14-.14v-.42a1.32 1.32 0 01.47-1.1 4.34 4.34 0 01.36-.3c.31-.23.66-.44 1-.64a15.25 15.25 0 001.45-.98 5.64 5.64 0 001.8-2.28 6.53 6.53 0 00.35-3.76 6.46 6.46 0 00-3.12-4.46 8.46 8.46 0 00-6.42-.9 9.98 9.98 0 00-4.02 2.28 10.74 10.74 0 00-.8.8c-.07.07-.08.13 0 .2a1.12 1.12 0 01.1.1l2.24 2.23.32.35zm6.95 15.28a2.77 2.77 0 10-2.78 2.76 2.77 2.77 0 002.78-2.76z" style="fill:#fff"/>
                        <path d="M51.81 29.63a10.4 10.4 0 01-1.88 5.35 13.36 13.36 0 01-3.94 3.71 1.75 1.75 0 01-.2.13.2.2 0 00-.13.25 9.46 9.46 0 002.2 4.8.78.78 0 01.18.27.64.64 0 01-.66.86 9.32 9.32 0 01-1.92-.24 11.59 11.59 0 01-4.14-2 15.47 15.47 0 01-1.8-1.53.43.43 0 00-.4-.14 18.57 18.57 0 01-4.05.06 17.23 17.23 0 01-6.16-1.73 13.94 13.94 0 01-4.8-3.86 11.3 11.3 0 01-1.3-2.08.5.5 0 01-.09-.24l.85-.1a22.89 22.89 0 004.44-.99 20.61 20.61 0 007.17-4.01 16.08 16.08 0 004.38-5.94 13.55 13.55 0 001.06-4.54l.02-.3c.01-.14.01-.14.17-.1q.64.13 1.26.32a15.5 15.5 0 015.72 3.1 11.84 11.84 0 013.34 4.62 10.4 10.4 0 01.63 2.46 2.35 2.35 0 00.05.54z" style="fill:#fff"/>
                        <path d="M15.96 11.27l-.33-.36-2.24-2.24a1.12 1.12 0 00-.1-.1c-.08-.06-.07-.12 0-.2a10.74 10.74 0 01.8-.8A9.98 9.98 0 0118.1 5.3a8.46 8.46 0 016.42.9 6.46 6.46 0 013.12 4.46 6.53 6.53 0 01-.34 3.76 5.64 5.64 0 01-1.81 2.28 15.25 15.25 0 01-1.45.98c-.34.2-.69.4-1 .65a4.34 4.34 0 00-.36.3 1.32 1.32 0 00-.47 1.1v.41c0 .11-.04.15-.14.14h-3.92c-.06 0-.1-.03-.1-.1a10.48 10.48 0 01.12-2.26 3.77 3.77 0 01.98-1.73 7.2 7.2 0 011.31-1.05l1.4-.88a6.28 6.28 0 001.1-.85 2.04 2.04 0 00.4-2.47 3.05 3.05 0 00-1.75-1.5 4.02 4.02 0 00-3.1.1 8.8 8.8 0 00-2.36 1.55l-.2.17zm6.95 15.27a2.77 2.77 0 11-2.76-2.79 2.76 2.76 0 012.76 2.79z" style="fill:#fd5000"/>
                    </symbol>
                    <use xlink:href="#bgsu-askus"></use>
                </svg>
            </a>
        `,
    });

    // Add help text to be displayed if there are no results on Browse Search.
    app.component('prmBrowseSearchAfter', {
        bindings: {
            parentCtrl: '<',
        },
        template: `
            <md-content class="main" ng-if="!$ctrl.parentCtrl.showList()" flex>
                <div class="padding-medium" flex-md="50" flex-lg="50" flex-xl="50" ng-class="{'flex-lgPlus-70': $ctrl.mediaQueries.lgPlus}">
                    <md-card class="default-card">
                        <md-card-title>
                            <h2 translate="nui.browse.help.title"></h2>
                        </md-card-title>
                        <md-card-content>
                            <span translate="nui.browse.help.description"></span>
                            <ul>
                                <li translate="nui.browse.help.option1"></li>
                                <li translate="nui.browse.help.option2"></li>
                            </ul>
                        </md-card-content>
                    </md-card>
                </div>
            </md-content>
        `
    });
})();
