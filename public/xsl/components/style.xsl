<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="generalStyle">
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style><![CDATA[
            @import url("https://use.typekit.net/aca8pmr.css");

            #outlook a {
                padding: 0;
            }

            a:link,
            a:visited {
                color: #DF3602;
                text-decoration: underline;
                text-decoration-color: #F5C163;
                text-decoration-thickness: 1px;
                text-underline-offset: 2px;
                transition: all .3s ease;
            }

            a:focus,
            a:hover {
                color: #FD5000;
                text-decoration-color: #F1C052;
                text-decoration-thickness: 2px;
            }

            img {
                transition: all .4s ease;
                vertical-align: bottom;
                -ms-interpolation-mode: bicubic;
            }

            a img:hover,
            a img:hover {
                opacity: 0.8;
            }

            div.indent,
            p,
            table {
                margin: 13px 6px;
                padding: 0;
            }

            div.indent p,
            div.indent table {
                margin: 13px 0;
            }

            table {
                border-collapse: collapse;
                mso-table-lspace: 0pt;
                mso-table-rspace: 0pt;
            }

            [x-apple-data-detectors] {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important
                text-decoration: none !important;
            }
        ]]></style>
    </xsl:template>
    <xsl:template name="bodyStyleCss">background:#fff;color:#000;font:normal 300 16px/1.5 europa,Verdana,Helvetica,Arial,sans-serif;margin:0;padding:0 14px;-ms-webkit-text-size-adjust:100%;-webkit-text-size-adjust:100%</xsl:template>
    <xsl:template name="headerLogoStyleCss"></xsl:template>
    <xsl:template name="headerTableStyleCss"></xsl:template>
    <xsl:template name="listStyleCss"></xsl:template>
    <xsl:template name="mainTableStyleCss"></xsl:template>
    <xsl:template name="footerTableStyleCss"></xsl:template>
</xsl:stylesheet>
