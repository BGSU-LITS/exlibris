(() => {
    const app = angular.module('viewCustom', ['angularLoad']);
    const vid = window.appConfig.vid;
    const url = '/discovery/custom/' + vid.replace(':', '-') + '/html/';

    // Add BGSU University Librtaries above top bar.
    app.component('prmTopBarBefore', {
        templateUrl: url + 'prmTopBarBefore.html'
    });

    // Add BGSU link icons after favorites icon.
    app.component('prmSearchBookmarkFilterAfter', {
        templateUrl: url + 'prmSearchBookmarkFilterAfter.html'
    });

    // Show search profile slots by default.
    app.component('prmSearchBarAfter', {
        controller: function($scope) {
            this.$onInit = function() {
                $scope.$parent.$ctrl.showTabsAndScopes = true;
            }
        }
    });

    // Collapse the Other Institutions list by default.
    app.component('prmAlmaOtherMembersAfter', {
        controller: function($scope) {
            this.$onInit = function () {
                $scope.$parent.$ctrl.isCollapsed = true;
            }
        }
    });

    // Automatically search when a profile slot is selected.
    window.appConfig['primo-view']['attributes-map'].tabsRemote = 'true';

    // Do not open menu links in new tabs/windows.
    const menu = window.appConfig.tiles.MainMenuTileInterface;

    for (const key in menu) {
        for (let count = 0; count < menu[key].mainview.length; count++) {
            menu[key].mainview[count].target = '_self';
        }
    }

    // Load BGSU University Libraries proactive chat.
    const script = document.createElement('script');

    script.src = 'https://lib.bgsu.edu/template/2.0.0-b20/libchat.js';
    script.defer = true;

    script.addEventListener('load', () => {
        bgsu_libchat.setup(
            'https://bgsu.libanswers.com/chat/widget/1d32264c0ea43602bbbbf36436c0d569',
            3057,
            [{d:[7259]}],
        );
    });

    document.head.appendChild(script);
})();
