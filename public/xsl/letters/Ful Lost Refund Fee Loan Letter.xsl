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

				<p>@@following_loaned_item_which_has@@</p>

				<xsl:for-each select="notification_data">
				    <p>
						<strong>@@title@@: </strong> <xsl:value-of select="item_loan/title"/>
						<br />
						<strong>@@loan_details@@: </strong> <xsl:value-of select="item_loan/description"/>
						<br />
						<strong>@@author@@: </strong> <xsl:value-of select="item_loan/author"/>
						<br />
						<strong>@@library@@: </strong> <xsl:value-of select="organization_unit/name"/>
						<br />
						<strong>@@loan_date@@: </strong> <xsl:value-of select="item_loan/loan_date"/>
						<br />
						<strong>@@due_date@@: </strong> <xsl:value-of select="item_loan/due_date"/>
					</p>
				</xsl:for-each>

				<p>
					<strong>@@your_account_balance_will_be_credited@@:</strong>
					<br />
					@@bellow_details_charges_credits_due@@
				</p>

				<table>
					<tr>
						<th>@@fee_type@@</th>
						<th align="right">@@fee_amount@@</th>
						<th>@@note@@</th>
					</tr>
					<xsl:for-each select="notification_data/fines_fees_list/user_fines_fees">
    					<tr>
    						<td><xsl:value-of select="fine_fee_type_display"/></td>
    						<td align="right"><xsl:value-of select="fine_fee_ammount/normalized_sum"/>&#160;<xsl:value-of select="fine_fee_ammount/currency"/></td>
    						<td><xsl:value-of select="finecomment"/></td>
    					</tr>
					</xsl:for-each>
					<tr>
						<td align="right"><strong>@@total@@:</strong></td>
						<td align="right"><xsl:value-of select="notification_data/total_fines_amount"/>&#160;<xsl:value-of select="notification_data/fines_fees_list/user_fines_fees[1]/fine_fee_ammount/currency"/></td>
					</tr>
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
