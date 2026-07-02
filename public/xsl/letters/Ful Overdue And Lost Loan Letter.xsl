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
                <p>
					@@inform_you_item_below@@
					@@borrowed_by_you@@ @@decalred_as_lost@@
                </p>
                <table>
                    <xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
                        <tr>
                            <th colspan="8">
                                <div class="h1">
                                    <xsl:value-of select="organization_unit/name"/>
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <th>@@lost_item@@</th>
                            <th>@@description@@</th>
                            <th>@@library@@</th>
                            <th>@@loan_date@@</th>
                            <th>@@due_date@@</th>
                            <th>@@barcode@@</th>
                            <th>@@call_number@@</th>
                            <th>@@charged_with_fines_fees@@</th>
                        </tr>
                        <xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display">
                            <tr>
                                <td valign="top">
                                    <xsl:value-of select="item_loan/title"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="item_loan/description"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="physical_item_display_for_printing/library_name"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="item_loan/loan_date"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="item_loan/due_date"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="item_loan/barcode"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="physical_item_display_for_printing/call_number"/>
                                </td>
                                <td valign="top">
                                    <xsl:for-each select="fines_fees_list/user_fines_fees">
                                        <xsl:sort select="fine_fee_ammount/normalized_sum" data-type="number"/>
                                        <p>
                                            <b><xsl:value-of select="fine_fee_type_display"/>: </b>
                                            <xsl:value-of select="fine_fee_ammount/normalized_sum"/>
                                            <xsl:text>&#160;</xsl:text>
                                            <xsl:value-of select="fine_fee_ammount/currency"/>
                                            <xsl:value-of select="ff"/>
                                        </p>
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </xsl:for-each>
                </table>
                <xsl:if test="notification_data/overdue_notification_fee_amount/sum !=''">
                    <p>
                        <b>@@overdue_notification_fee@@ </b>
                        <xsl:value-of select="notification_data/overdue_notification_fee_amount/normalized_sum"/>
                        <xsl:text>&#160;</xsl:text>
                        <xsl:value-of select="notification_data/overdue_notification_fee_amount/currency"/>
                        <xsl:value-of select="ff"/>
                    </p>
                </xsl:if>
                <p>
                    @@additional_info_1@@
					@@additional_info_2@@
                </p>
                <xsl:call-template name="sincerely">
                    <xsl:with-param name="sincerely">@@sincerely@@</xsl:with-param>
                    <xsl:with-param name="department">@@department@@</xsl:with-param>
                </xsl:call-template><!-- mailReason.xsl -->
                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
