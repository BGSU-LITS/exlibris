<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="header.xsl"/>
    <xsl:include href="senderReceiver.xsl"/>
    <xsl:include href="mailReason.xsl"/>
    <xsl:include href="footer.xsl"/>
    <xsl:include href="style.xsl"/>
    <xsl:include href="recordTitle.xsl"/>
    <xsl:template name="formatDateTime">
        <xsl:param name="datetime"/>
        <xsl:variable name="match" select="'^([0-9]{2})/([0-9]{2})/([0-9]{4}) ([0-9]{2}):([0-9]{2})(?::([0-9]{2}))?(.*)$'"/>
        <xsl:choose>
            <xsl:when test="matches($datetime, $match)">
                <xsl:value-of select="replace($datetime, $match, '$1/$2/$3 ')"/>
                <xsl:variable name="hour" select="number(replace($datetime, $match, '$4'))"/>
                <xsl:choose>
                    <xsl:when test="$hour = 0">
                        12
                        <xsl:value-of select="replace($datetime, $match, ':$5 AM $7')"/>
                    </xsl:when>
                    <xsl:when test="$hour &lt; 12">
                        <xsl:value-of select="$hour"/>
                        <xsl:value-of select="replace($datetime, $match, ':$5 AM $7')"/>
                    </xsl:when>
                    <xsl:when test="$hour = 12">
                        12
                        <xsl:value-of select="replace($datetime, $match, ':$5 PM $7')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$hour - 12"/>
                        <xsl:value-of select="replace($datetime, $match, ':$5 PM $7')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$datetime"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
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
                <p>@@inform_loaned_items@@ <xsl:value-of select="notification_data/organization_unit/name" />:</p>
                <table>
                    <tr>
                        <th>@@title@@</th>
                        <th>@@description@@</th>
                        <th>@@author@@</th>
                        <th>@@loan_date@@</th>
                        <th>@@due_date@@</th>
                        <th>@@library@@</th>
                    </tr>
                    <xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
                        <xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display/item_loan">
                            <tr>
                                <td><xsl:value-of select="title"/></td>
                                <td><xsl:value-of select="description"/></td>
                                <td><xsl:value-of select="author"/></td>
                                <td><xsl:value-of select="loan_date"/></td>
                                <td>
                                    <xsl:call-template name="formatDateTime">
                                        <xsl:with-param name="datetime" select="new_due_date_str"/>
                                    </xsl:call-template>
                                </td>
                                <td><xsl:value-of select="library_name"/></td>
                            </tr>
                        </xsl:for-each>
                    </xsl:for-each>
                </table>
                <xsl:call-template name="sincerely">
                    <xsl:with-param name="sincerely">@@sincerely@@</xsl:with-param>
                    <xsl:with-param name="department">@@department@@</xsl:with-param>
                </xsl:call-template><!-- mailReason.xsl -->
                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
