<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="header.xsl"/>
    <xsl:include href="senderReceiver.xsl"/>
    <xsl:include href="mailReason.xsl"/>
    <xsl:include href="footer.xsl"/>
    <xsl:include href="style.xsl"/>
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
    			<xsl:if test="notification_data/item_loans/item_loan or notification_data/overdue_item_loans/item_loan">
                    <p>@@reminder_message@@</p>
    	            <xsl:if test="notification_data/overdue_loans_by_library/library_loans_for_display">
                        <div class="indent">
                            <div class="h1">@@overdue_loans@@</div>
                            <table>
                                <xsl:for-each select="notification_data/overdue_loans_by_library/library_loans_for_display">
                                    <tr>
                                        <td colspan="4"><div class="h2"><xsl:value-of select="organization_unit/name"/></div></td>
                                    </tr>
                                    <tr>
                                        <th>@@title@@</th>
                                        <th>@@description@@</th>
                                        <th>@@author@@</th>
                                        <th>@@due_date@@</th>
                                        <th>@@fine@@</th>
                                    </tr>
                                    <xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display/item_loan">
                                        <tr>
                                            <td valign="top"><xsl:value-of select="title"/></td>
                                            <td valign="top"><xsl:value-of select="description"/></td>
                                            <td valign="top"><xsl:value-of select="author"/></td>
                                            <td valign="top"><xsl:value-of select="due_date"/></td>
                                            <td valign="top"><xsl:value-of select="normalized_fine"/></td>
                                        </tr>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </table>
                        </div>
	    			</xsl:if>
    				<xsl:if test="notification_data/loans_by_library/library_loans_for_display">
                        <div class="indent">
                            <div class="h1">@@loans@@</div>
                            <table>
                                <xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
                                    <tr>
                                        <td colspan="4"><div class="h2"><xsl:value-of select="organization_unit/name"/></div></td>
                                    </tr>
                                    <tr>
                                        <th>@@title@@</th>
                                        <th>@@description@@</th>
                                        <th>@@author@@</th>
                                        <th>@@due_date@@</th>
                                    </tr>
                                    <xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display/item_loan">
                                        <tr>
                                            <td valign="top"><xsl:value-of select="title"/></td>
                                            <td valign="top"><xsl:value-of select="description"/></td>
                                            <td valign="top"><xsl:value-of select="author"/></td>
                                            <td valign="top"><xsl:value-of select="due_date"/></td>
                                        </tr>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </table>
                        </div>
	    			</xsl:if>
			    </xsl:if>
			    <xsl:if test="notification_data/organization_fee_list/string">
                    <div class="indent">
                        <div class="h1">@@debt_message@@</div>
                        <xsl:for-each select="notification_data/organization_fee_list/string">
                            <div><xsl:value-of select="."/></div>
                        </xsl:for-each>
                    </div>
                    <p><strong>@@total@@ <xsl:value-of select="notification_data/total_fee"/></strong></p>
                    <p><strong>@@please_pay_message@@</strong></p>
                </xsl:if>
                <xsl:call-template name="sincerely">
                    <xsl:with-param name="sincerely">@@sincerely@@</xsl:with-param>
                    <xsl:with-param name="department">@@department@@</xsl:with-param>
                </xsl:call-template><!-- mailReason.xsl -->
                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
