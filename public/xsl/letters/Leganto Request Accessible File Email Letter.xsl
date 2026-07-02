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

    			<!-- Opening statement -->
                <p>@@user_ requested_accessible_file.statment@@</p>

                <!-- Item details section -->
                <p>
                    <strong>@@Item_details_header@@</strong><br/>
					@@Item_title@@ <xsl:value-of select="notification_data/item_title" /><br/>
					@@Item_author@@ <xsl:value-of select="notification_data/item_author" /><br/>
				</p>

				<xsl:if test="notification_data/user_feedback !=''">
				    <p>@@Request_comment@@ <xsl:value-of select="notification_data/user_feedback" /></p>
				</xsl:if>

    			<xsl:if test="notification_data/item_url !=''">
                    <p>
  						<xsl:element name="a">
 							<xsl:attribute name="href">
								<xsl:value-of select="notification_data/item_url" />
 							</xsl:attribute>
 							@@View_in_leganto@@
  						</xsl:element>
    				</p>
    			</xsl:if>

				<!-- Course details section -->
				<p>
					<strong>@@Course_details_header@@</strong><br/>
					@@Course_name@@ <xsl:value-of select="notification_data/course_name" /><br/>
					@@Course_code@@ <xsl:value-of select="notification_data/course_code" /><br/>
    				<xsl:if test="notification_data/course_instructors !=''">
        				@@Course_instructor@@ <xsl:value-of select="notification_data/course_instructors" />
    				</xsl:if>
                </p>

				<!-- Requester details section -->
				<p>
					<strong>@@User_details_header@@</strong><br/>
					<xsl:value-of select="notification_data/user_full_name" /><br/>
					@@User_email@@ <xsl:value-of select="notification_data/user_email_address" /><br/>
    				<xsl:if test="notification_data/additional_email_addresses/string">
        				@@Additional_email_address@@ <xsl:for-each select="notification_data/additional_email_addresses/string"><xsl:value-of select="." /><xsl:if test="position() != last()">, </xsl:if></xsl:for-each>
    				</xsl:if>
                </p>

                <p>@@Signature@@</p>

                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
