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

                <p>@@subject@@</p>
                <p>
                    @@list@@&#160;<xsl:value-of select="notification_data/list_name" /><br/>
					@@item@@&#160;<xsl:value-of select="notification_data/item_title" /><br/>
					@@citation_id@@&#160;<xsl:value-of select="notification_data/assertion/entity_id" /><br/>

					<xsl:if test="(notification_data/item_url  !='') and (notification_data/type  !='fileDownload')">
						@@reported_link@@&#160;
						<xsl:if test="notification_data/item_url  !=''">
							<xsl:element name="a">
								<xsl:attribute name="href">
									<xsl:value-of select="notification_data/item_url" />
								</xsl:attribute>
								<xsl:value-of select="notification_data/item_url_name" />
							</xsl:element>
						</xsl:if>
						<br/>
					</xsl:if>
					<xsl:if test="notification_data/type  ='fileDownload'">
					    @@reported_file@@&#160;<xsl:value-of select="notification_data/name" /><br/>
					</xsl:if>
					<xsl:if test="notification_data/item_url  =''">
					    @@no_availability@@<br/>
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
                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
