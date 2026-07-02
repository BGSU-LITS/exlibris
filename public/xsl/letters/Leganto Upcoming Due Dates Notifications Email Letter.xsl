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

                <p>@@due_dates_approaching@@</p>

				<xsl:for-each
					select="notification_data/courses_to_citations/course_citations_wrapper">
				    <p>
						<strong>
							<xsl:value-of select="course/name" />
						</strong>
						<br/>

    					<xsl:for-each select="citations/reading_list_citation">
							<xsl:value-of select="due_date" />
							-
							<xsl:value-of select="title" />
							<br/>
    					</xsl:for-each>
                    </p>
                </xsl:for-each>

				<xsl:if test="notification_data/leganto_url  !=''">
				    <p>
						@@see_all_your_lists@@
						<xsl:element name="a">
							<xsl:attribute name="href">
							    <xsl:value-of select="notification_data/leganto_url" />
							</xsl:attribute>
							@@go_leganto@@
						</xsl:element>
					</p>
				</xsl:if>

                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
