<?xml version="1.0" encoding="utf-8"?>
<!--
https://lib.bgsu.edu/exlibris/
Author: John Kloor <kloor@bgsu.edu>
Revised: 2025-01-14

Important: The script.src for JsBarcode should be changed to a URL that your
institution controls, instead of the default CDN. This Javascript will be
executed within Alma, and therefore assume the user's security context.

Alma prints multiple pages by including the full HTML content of the first
page as-is, and then adding each additional page's full content within a
paragraph element. Browsers do not consistently interpret this code, so this
file instead uses an article element, and ignores the paragraph element.

As every element, including the script element, are included several times,
the script to load JsBarcode is designed so that it is only executed once.

Alma does not allow for the additon of labels, so the following words below are
coded within the file: Title, Author, Description, Library
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <xsl:if test="notification_data/languages/string">
                <xsl:attribute name="lang">
                    <xsl:value-of select="notification_data/languages/string"/>
                </xsl:attribute>
            </xsl:if>
            <head>
                <title>
                    <xsl:value-of select="notification_data/general_data/subject"/>
                </title>
                <style>
                <![CDATA[
                    @page{margin:0}
                    @page portrait{size:letter portrait}
                    *,*:before,*:after{box-sizing:inherit}
                    html{box-sizing:border-box}
                    body{background:#fff;color:#000;font:12pt/1.25 "Helvetica Neue",Helvetica,Arial,sans-serif;margin:0;padding:0}
                    body>p{display:none}
                    article{break-after:page;height:11in;padding:0.25in;page:portrait;width:8.5in}
                    h1{float:left;font-size:2rem;font-weight:normal;height:5in;margin:0 1rem 0 0;transform:scale(-1);writing-mode:vertical-rl}
                    svg{vertical-align:top}
                    p,table{margin:0 0 1rem 0}
                    table{border-collapse:collapse}
                    td,th{padding:0 0.5rem 0 0;text-align:left;vertical-align:top}
                    th{white-space:nowrap}
                ]]>
                </style>
                <script>
                <![CDATA[
                    if (typeof script === 'undefined') {
                        var script = document.createElement('script');

                        script.src = 'https://cdn.jsdelivr.net/npm/jsbarcode@3.11.6/dist/barcodes/JsBarcode.code39.min.js';
                        script.defer = true;

                        script.addEventListener('load', () => {
                            JsBarcode('.barcode39').options({
                                font: '"Helvetica Neue",Helvetica,Arial,sans-serif',
                                fontSize: 16,
                                format: 'code39',
                                height: 34,
                                margin: 0,
                                width: 1
                            }).init();
                        });

                        document.head.appendChild(script);
                    }
                ]]>
                </script>
            </head>
            <body>
                <article>
                    <h1>
                        <xsl:value-of select="notification_data/user_for_printing/name"/>
                    </h1>
                    <div style="float:right">
                        <svg class="barcode39">
                            <xsl:attribute name="data-value">
                                <xsl:value-of select="notification_data/request_id"/>
                            </xsl:attribute>
                        </svg>
                    </div>
                    <p>
                        <xsl:value-of select="notification_data/general_data/current_date"/>
                    </p>
                    <table>
                        <xsl:if test="notification_data/external_id!=''">
                            <tr>
                                <th>@@external_id@@</th>
                                <td>
                                    <xsl:value-of select="notification_data/external_id"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/user_for_printing/name">
                            <tr>
                                <th>@@requested_for@@</th>
                                <td>
                                    <xsl:value-of select="notification_data/user_for_printing/name"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/proxy_requester/name">
                            <tr>
                                <th>@@proxy_requester@@</th>
                                <td>
                                    <xsl:value-of select="notification_data/proxy_requester/name"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <tr>
                            <th>@@move_to_library@@</th>
                            <td>
                                <xsl:value-of select="notification_data/destination"/>
                            </td>
                        </tr>
                        <tr>
                            <th>@@request_type@@</th>
                            <td>
                                <xsl:value-of select="notification_data/request_type"/>
                            </td>
                        </tr>
                        <xsl:if test="notification_data/request/system_notes!=''">
                            <tr>
                                <th>@@system_notes@@</th>
                                <td>
                                    <xsl:value-of select="notification_data/request/system_notes"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/request/note!=''">
                            <tr>
                                <th>@@request_note@@</th>
                                <td>
                                    <xsl:value-of select="notification_data/request/note"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/request/manual_description!=''">
                            <tr>
                                <th>@@please_note@@</th>
                                <td>@@manual_description_note@@ - <xsl:value-of select="notification_data/request/manual_description"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <tr>
                            <td>&#160;</td>
                        </tr>
                        <tr>
                            <th>Title</th>
                            <td>
                                <xsl:value-of select="notification_data/phys_item_display/title"/>
                            </td>
                        </tr>
                        <xsl:if test="notification_data/phys_item_display/author!=''">
                            <tr>
                                <th>Author</th>
                                <td>
                                    <xsl:value-of select="notification_data/phys_item_display/author"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/phys_item_display/issue_level_description!=''">
                            <tr>
                                <th>Description</th>
                                <td>
                                    <xsl:value-of select="notification_data/phys_item_display/issue_level_description"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/phys_item_display/isbn!=''">
                            <tr>
                                <th>@@isbn@@</th>
                                <td>
                                    <xsl:value-of select="notification_data/phys_item_display/isbn"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/phys_item_display/issn!=''">
                            <tr>
                                <th>@@issn@@</th>
                                <td>
                                    <xsl:value-of select="notification_data/phys_item_display/issn"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/phys_item_display/edition!=''">
                            <tr>
                                <th>@@edition@@</th>
                                <td>
                                    <xsl:value-of select="notification_data/phys_item_display/edition"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/phys_item_display/imprint!=''">
                            <tr>
                                <th>@@imprint@@</th>
                                <td>
                                    <xsl:value-of select="notification_data/phys_item_display/imprint"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="count(notification_data/phys_item_display/available_items/available_item) &lt; 2">
                            <tr>
                                <td>&#160;</td>
                            </tr>
                            <tr>
                                <th>Library</th>
                                <td>
                                    <xsl:value-of select="notification_data/phys_item_display/owning_library_name"/>
                                </td>
                            </tr>
                            <tr>
                                <th>@@location@@</th>
                                <td>
                                    <xsl:value-of select="notification_data/phys_item_display/location_name"/>
                                </td>
                            </tr>
                            <xsl:if test="notification_data/phys_item_display/call_number!=''">
                                <tr>
                                    <th>@@call_number@@</th>
                                    <td>
                                        <xsl:value-of select="notification_data/phys_item_display/call_number"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="notification_data/phys_item_display/accession_number!=''">
                                <tr>
                                    <th>@@accession_number@@</th>
                                    <td>
                                        <xsl:value-of select="notification_data/phys_item_display/accession_number"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="notification_data/phys_item_display/shelving_location/string">
                                <tr>
                                    <th>@@shelving_location_for_item@@</th>
                                    <td>
                                        <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
                                            <xsl:value-of select="."/>
                                            <xsl:text></xsl:text>
                                        </xsl:for-each>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="notification_data/phys_item_display/display_alt_call_numbers/string">
                                <tr>
                                    <th>@@alt_call_number@@</th>
                                    <td>
                                        <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
                                            <xsl:value-of select="."/>
                                            <xsl:text></xsl:text>
                                        </xsl:for-each>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="notification_data/phys_item_display/barcode!=''">
                                <tr>
                                    <th>@@item_barcode@@</th>
                                    <td>
                                        <svg class="barcode39">
                                            <xsl:attribute name="data-value">
                                                <xsl:value-of select="notification_data/phys_item_display/barcode"/>
                                            </xsl:attribute>
                                        </svg>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="notification_data/phys_item_display/barcode=''">
                                <xsl:if test="notification_data/phys_item_display/optional_barcodes/string!=''">
                                    <tr>
                                        <th>@@item_barcode@@</th>
                                        <td>
                                            <svg class="barcode39">
                                                <xsl:attribute name="data-value">
                                                    <xsl:value-of select="notification_data/phys_item_display/optional_barcodes/string"/>
                                                </xsl:attribute>
                                            </svg>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:if>
                        </xsl:if>
                    </table>
                    <xsl:if test="count(notification_data/phys_item_display/available_items/available_item) &gt; 1">
                        <table>
                            <tr>
                                <th>Library</th>
                                <th>@@location@@</th>
                                <th>@@call_number@@</th>
                                <th>@@item_barcode@@</th>
                            </tr>
                            <xsl:for-each select="notification_data/phys_item_display/available_items/available_item">
                                <tr>
                                    <td>
                                        <xsl:value-of select="library_name"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="location_name"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="call_number"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="barcode"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </xsl:if>
                    <xsl:if test="notification_data/request/selected_inventory_type='ITEM'">
                        <p>
                            <strong>@@note_item_specified_request@@.</strong>
                        </p>
                    </xsl:if>
                </article>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
