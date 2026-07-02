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
                <xsl:if test="notification_data/transaction_id!=''">
					<p><strong>@@transaction_id@@: <xsl:value-of select="/notification_data/transaction_id"/></strong></p>
				</xsl:if>
				<xsl:for-each select="notification_data/labels_list">
				    <p><xsl:value-of select="letter.fineFeePaymentReceiptLetter.message"/></p>
				</xsl:for-each>
				<table>
					<tr>
						<th>@@fee_type@@</th>
						<th align="right">@@payment_date@@</th>
						<th align="right">@@paid_amount@@</th>
						<th>@@payment_method@@</th>
						<th>@@note@@</th>
					</tr>
					<xsl:for-each select="notification_data/user_fines_fees_list/user_fines_fees">
    					<tr>
    						<td><xsl:value-of select="fine_fee_type_display"/></td>
    						<td align="right"><xsl:value-of select="create_date"/></td>
    						<td align="right"><xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_ammount/currency"/><xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_amount_display"/></td>
    						<td><xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_payment_method_display"/></td>
    						<td><xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_note"/></td>
    					</tr>
					</xsl:for-each>
					<tr>
						<th align="right" colspan="2">@@total@@:</th>
						<td align="right"><xsl:value-of select="notification_data/total_amount_paid"/></td>
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
