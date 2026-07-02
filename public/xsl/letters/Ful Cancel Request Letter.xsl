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
                    @@on@@
                    <xsl:value-of select="notification_data/general_data/current_date" />
                    @@we_cancel_y_req_of@@
                    <xsl:value-of select="notification_data/request/create_date" />
                    @@detailed_below@@:
                </p>
                <p>
                    <xsl:call-template name="recordTitle"/><!-- recordTitle.xsl -->
                </p>
                <xsl:if test="notification_data/request/start_time!=''">
                    <p>
                        <strong>@@start_time@@: </strong>
                        <xsl:value-of select="notification_data/booking_start_time_str"/>
                    </p>
                </xsl:if>
                <xsl:if test="notification_data/request/end_time!=''">
                    <p>
                        <strong>@@end_time@@: </strong>
                        <xsl:value-of select="notification_data/booking_end_time_str"/>
                    </p>
                </xsl:if>
                <xsl:if test="notification_data/request/note!=''">
                    <p>
                        <strong>@@request_note@@: </strong>
                        <xsl:value-of select="notification_data/request/note"/>
                    </p>
                </xsl:if>
                <p>
                    <strong>@@reason_deleting_request@@: </strong>
                    <xsl:value-of select="notification_data/request/status_note_display"/>
                </p>
                <xsl:if test="notification_data/request/cancel_reason!=''">
                    <p>
                        <strong>@@request_cancellation_note@@: </strong>
                        <xsl:value-of select="notification_data/request/cancel_reason"/>
                    </p>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="starts-with(notification_data/request/assigned_unit_name, 'Browne Popular Culture Library')">
                        <p>If you have any questions or believe you have received this message in error, please contact us at <a href="mailto:bpcl@libanswers.bgsu.edu">bpcl@libanswers.bgsu.edu</a>.</p>
                    </xsl:when>
                    <xsl:when test="starts-with(notification_data/request/assigned_unit_name, 'Center for Archival Collections')">
                        <p>If you have any questions or believe you have received this message in error, please contact us at <a href="mailto:cac@libanswers.bgsu.edu">cac@libanswers.bgsu.edu</a>.</p>
                    </xsl:when>
                    <xsl:when test="starts-with(notification_data/request/assigned_unit_name, 'Music Library')">
                        <p>If you have any questions or believe you have received this message in error, please contact us at <a href="mailto:mlbssa@libanswers.bgsu.edu">mlbssa@libanswers.bgsu.edu</a>.</p>
                    </xsl:when>
                </xsl:choose>
                <xsl:call-template name="sincerely">
                    <xsl:with-param name="sincerely">@@sincerely@@</xsl:with-param>
                    <xsl:with-param name="department">
                        <xsl:choose>
                            <xsl:when test="starts-with(notification_data/request/assigned_unit_name, 'Browne Popular Culture Library')">
                                Browne Popular Culture Library Staff
                            </xsl:when>
                            <xsl:when test="starts-with(notification_data/request/assigned_unit_name, 'Center for Archival Collections')">
                                CAC Staff
                            </xsl:when>
                            <xsl:when test="starts-with(notification_data/request/assigned_unit_name, 'Music Library')">
                                Music Library and Bill Schurk Sound Archives Staff
                            </xsl:when>
                            <xsl:otherwise>
                                @@department@@
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:with-param>
                </xsl:call-template><!-- mailReason.xsl -->
                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
