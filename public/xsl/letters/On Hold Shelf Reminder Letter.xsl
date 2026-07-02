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

                <p>@@following_items_awaiting_pickup@@</p>

                <table>
                    <xsl:for-each select="notification_data/requests_by_library/library_requests_for_display">
                        <tr>
                            <th colspan="4">
                                <div class="h1">
                                    <xsl:value-of select="organization_unit/name"/>
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <th>@@title@@</th>
                            <th>@@author@@</th>
                            <th>@@can_picked_at@@</th>
                            <th>@@note_item_held_until@@</th>
                        </tr>
                        <xsl:for-each select="requests/request_for_display">
                            <tr>
                                <td valign="top">
                                    <xsl:value-of select="phys_item_display/title"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="phys_item_display/author"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="request/assigned_unit_name"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="request/work_flow_entity/expiration_date"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </xsl:for-each>
                    <xsl:if test="notification_data/out_of_institution_requests/request_for_display">
                        <tr>
                            <th colspan="4">
                                <div class="h1">
                                    @@other_institutions@@
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <th>@@title@@</th>
                            <th>@@author@@</th>
                            <th>@@can_picked_at@@</th>
                            <th>@@note_item_held_until@@</th>
                        </tr>
                        <xsl:for-each select="notification_data/out_of_institution_requests/request_for_display">
                            <tr>
                                <td valign="top">
                                    <xsl:value-of select="phys_item_display/title"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="phys_item_display/author"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="request/assigned_unit_name"/>
                                </td>
                                <td valign="top">
                                    <xsl:value-of select="request/work_flow_entity/expiration_date"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </xsl:if>
                </table>

                <xsl:if test="notification_data/user_for_printing/blocks != ''">
                    <p>
                        <b>@@notes_affect_loan@@:</b><br/>
                        <xsl:value-of select="notification_data/user_for_printing/blocks"/>
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
