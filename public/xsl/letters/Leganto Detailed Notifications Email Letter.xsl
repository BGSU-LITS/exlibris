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
					@@you_have@@
					<xsl:value-of select="notification_data/total_count" />
					@@new_notifications@@
				</p>

				<xsl:for-each select="notification_data/events/detailed_notifications_summary">
				    <p>
						<strong>@@list@@ <xsl:value-of select="list_name" /></strong><br/>
   					    <xsl:for-each select="notification_list/notifications_summary">
 							<xsl:value-of select="num_of_events" />&#160;<xsl:value-of select="event_type_display" />
 							<br/>
  						</xsl:for-each>
  						<xsl:element name="a">
 							<xsl:attribute name="href">
 							    <xsl:value-of select="permalink_url" />
 							</xsl:attribute>
 							@@go_to@@
  						</xsl:element>
                    </p>
				</xsl:for-each>

				<xsl:for-each select="notification_data/delete_events/detailed_notifications_summary">
				    <p>
						<strong>@@LIST_DELETE@@</strong>
					   	<xsl:value-of select="list_name" />
					</p>
				</xsl:for-each>

				<xsl:for-each select="notification_data/course_sub_events/detailed_notifications_summary">
				    <p>
						<strong><xsl:value-of select="course_code" /> / <xsl:value-of select="course_name" />:</strong><br/>
						@@COURSE_SUBMIT_LISTS_BY@@: <xsl:value-of select="submit_lists_by" /><br/>
						<xsl:element name="a">
							<xsl:attribute name="href">
							    <xsl:value-of select="permalink_url" />
							</xsl:attribute>
							@@click_create_list@@
						</xsl:element>
					</p>
				</xsl:for-each>

				<p>
					@@see_all_your_lists@@
					<xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="notification_data/leganto_url" />
						</xsl:attribute>
						@@go_leganto@@
					</xsl:element>
				</p>

                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
