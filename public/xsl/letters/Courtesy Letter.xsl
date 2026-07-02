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

                <p>
					<xsl:if test="notification_data/short_loans='true'">
						<strong>@@short_loans_message@@</strong>
					</xsl:if>
					<xsl:if test="notification_data/short_loans='false'">
						<strong>@@message@@</strong>
					</xsl:if>
                </p>

                <div class="indent">
                    <div class="h1">@@loans@@</div>
				</div>

               	<table>
					<tr>
						<th>@@title@@</th>
						<th>@@description@@</th>
						<th>@@author@@</th>
						<th>@@due_date@@</th>
						<th>@@library@@</th>
					</tr>
              		<xsl:for-each select="notification_data/item_loans/item_loan">
    					<tr>
    						<td><xsl:value-of select="title"/></td>
    						<td><xsl:value-of select="description"/></td>
    						<td><xsl:value-of select="author"/></td>
    						<td><xsl:value-of select="due_date"/></td>
    						<td><xsl:value-of select="library_name"/></td>
    					</tr>
					</xsl:for-each>
               	</table>

				<div>@@additional_info_1@@</div>
				<div>@@additional_info_2@@</div>

                <xsl:call-template name="sincerely">
                    <xsl:with-param name="sincerely">@@sincerely@@</xsl:with-param>
                    <xsl:with-param name="department">@@department@@</xsl:with-param>
                </xsl:call-template><!-- mailReason.xsl -->
                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
