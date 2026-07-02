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
                    @@following_item_requested_on@@
                    <xsl:value-of select="notification_data/request/create_date"/>,
                    <xsl:choose>
                        <xsl:when test="starts-with(notification_data/request/assigned_unit_name, 'Browne Popular Culture Library')">
                            is available for pick up at the Service Desk in the Browne Popular Culture Library, located on the 4th floor of Jerome Library.
                        </xsl:when>
                        <xsl:when test="starts-with(notification_data/request/assigned_unit_name, 'Center for Archival Collections')">
                            can now be accessed at the CAC Reference Desk on the 5th floor of the Jerome Library. Please check our
                            <a href="https://www.bgsu.edu/library/about/library-hours.html?location=10067">current hours</a>
                            as you plan your visit.
                        </xsl:when>
                        <xsl:when test="starts-with(notification_data/request/assigned_unit_name, 'Music Library')">
                            is available for pick up at the Service Desk in the Music Library and Bill Schurk Sound Archives located on the 3rd floor of Jerome Library.
                        </xsl:when>
                        <xsl:otherwise>
                            @@can_picked_at@@
                            <xsl:value-of select="notification_data/request/assigned_unit_name"/>
                            @@circulation_desk@@.
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
                <xsl:if test="notification_data/request/work_flow_entity/expiration_date">
                    <p>
                        @@note_item_held_until@@
                        <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>.
                    </p>
                </xsl:if>
                <p>
                    <xsl:call-template name="recordTitle" /><!-- recordTitle.xsl -->
                </p>
				<xsl:if test="notification_data/request/system_notes!=''">
                    <p>
                        @@notes_affect_loan@@:<br/>
                        <xsl:value-of select="notification_data/request/system_notes"/>
                    </p>
				</xsl:if>
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
