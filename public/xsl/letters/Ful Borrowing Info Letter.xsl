<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="header.xsl"/>
    <xsl:include href="senderReceiver.xsl"/>
    <xsl:include href="mailReason.xsl"/>
    <xsl:include href="footer.xsl"/>
    <xsl:include href="style.xsl"/>
    <xsl:include href="recordTitle.xsl"/>
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
                <xsl:call-template name="generalStyle"/>
            </head>
            <body>
                <xsl:attribute name="style">
                    <xsl:call-template name="bodyStyleCss"/><!-- style.xsl -->
                </xsl:attribute>
                <xsl:call-template name="head"/><!-- header.xsl -->
                <xsl:call-template name="senderReceiver"/><!-- SenderReceiver.xsl -->
                <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->            

                <xsl:choose>
                    <xsl:when test="notification_data/success='true'">
                        <p><!--@@on@@ <xsl:value-of select="notification_data/general_data/current_date"/> @@we_renewed_y_req_from@@ <xsl:value-of select="notification_data/outgoing/create_date"/> @@detailed_below@@ :--></p>
                        <p>@@renewed_loan@@:</p>
                    </xsl:when>
                    <xsl:otherwise>
                        <p>@@not_renewed_loan@@:</p>
                    </xsl:otherwise>
                </xsl:choose>                
                <p><xsl:call-template name="recordTitle" /><!-- recordTitle.xsl --></p>
                <xsl:choose>
                    <xsl:when test="notification_data/success='true'">
                        <p>@@new_due_date@@: <xsl:value-of select="notification_data/item_loan_due_date"/></p>
                        <p><strong>@@success_reason@@</strong></p>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="notification_data/note != ''">
                                <p><strong>@@failure_reason@@: <xsl:value-of select="notification_data/note"/></strong></p>
                            </xsl:when>
                        </xsl:choose>
                        <p><strong>@@contact_dep@@</strong></p>
                    </xsl:otherwise>
                </xsl:choose>          

                <xsl:call-template name="sincerely">
                    <xsl:with-param name="sincerely">@@sincerely@@</xsl:with-param>
                    <xsl:with-param name="department">@@department@@</xsl:with-param>
                </xsl:call-template><!-- mailReason.xsl -->
                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
        