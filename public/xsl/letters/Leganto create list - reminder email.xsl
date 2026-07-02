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
					@@create_resource_list@@
					"<xsl:value-of select="notification_data/course/code" /> - <xsl:value-of select="notification_data/course/name" />".
				</p>

				<p>
				    @@latest_date_submission@@
					<xsl:value-of select="notification_data/due_date" />.
				</p>

				<p>
					@@share_with_students@@
					@@ensure_access@@
				</p>

				<xsl:if test="notification_data/leganto_url  !=''">
				    <p>
						<xsl:element name="a">
							<xsl:attribute name="href">
								<xsl:value-of select="notification_data/leganto_url" />
							</xsl:attribute>

							<xsl:attribute name="style">
								<xsl:value-of select="'color:#337ab7;font-weight:bold;'"/>
							</xsl:attribute>
							@@update_now@@
						</xsl:element>
					</p>
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
