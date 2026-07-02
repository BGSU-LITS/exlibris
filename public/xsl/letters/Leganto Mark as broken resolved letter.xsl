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

                <p>@@thank_you@@</p>
                <p>
                    @@list@@&#160;<xsl:value-of select="notification_data/list_name" /><br/>
                    @@item@@&#160;<xsl:value-of select="notification_data/item_title" /><br/>
					@@reported_on@@&#160;<xsl:value-of select="notification_data/assertion/create_date" /><br/>

					<xsl:if test="notification_data/note_to_student!=''">
						<xsl:value-of select="notification_data/note_to_student" />
					</xsl:if>
				</p>

				<xsl:if test="notification_data/leganto_url  !=''">
					<xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="notification_data/leganto_url" />
						</xsl:attribute>
						@@view_in_leganto@@
					</xsl:element>
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
