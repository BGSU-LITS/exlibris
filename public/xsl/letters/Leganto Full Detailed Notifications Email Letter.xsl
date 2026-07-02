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

				<xsl:for-each select="notification_data/full_events">
					<xsl:for-each select="reading_list_full_notifications_wrapper">
					    <p>
						    <strong><xsl:value-of select="reading_list_name" /></strong><br/>
							<xsl:element name="a">
						        <xsl:attribute name="href">
									<xsl:value-of select="permalink_url" />
								</xsl:attribute>
								@@go_to_list@@
							</xsl:element>
							<br/>
      						<xsl:if test="course_name">
     							<strong>@@courses@@:</strong> <xsl:value-of select="course_name" /><br/>
      						</xsl:if>
                        </p>

						<xsl:for-each select="event_groups/list_full_notification_event_group">
							<xsl:choose>
								<xsl:when test="event_type='PUBLIC_NOTE'">
								    <p><xsl:value-of select="events_count" />&#160;@@NOTE_FOR_STUDENT@@</p>
								</xsl:when>
								<xsl:when test=" event_type='SECTION_DELETE' or event_type='ITEM_COMPLETE' or event_type='ITEM_DECLINED' or event_type='SUGGESTION'  or event_type='CITATION_DELETE'  or event_type='DUE_DATE' or event_type='ITEM_ADD' or event_type='DISCUSSION' or event_type='RL_DISCUSSION' or event_type='NEW_EDITION_AVAILABLE' or event_type='SECTION_TAG' or event_type='SECTION_LIBRARY_TAG_DELETE' or event_type='SECTION_TAG_DELETE' or event_type='SECTION_LIBRARY_TAG_ADD' or event_type='CITATION_TAG' or event_type='CITATION_TAG_DELETE' or event_type='CITATION_LIBRARY_TAG_ADD' or event_type='CITATION_LIBRARY_TAG_DELETE'">
									<p><xsl:value-of select="events_count" />&#160;<xsl:value-of select="event_description" /></p>
								</xsl:when>
								<xsl:otherwise>
									<p><xsl:value-of select="events_count" /> &#160;<xsl:value-of select="event_description" /></p>
								</xsl:otherwise>
							</xsl:choose>

    					    <p>
    							<xsl:for-each select="list_notifications/reading_list_notifications_wrapper">
    								<xsl:if test="sys_event/event_type='SECTION_TAG' or sys_event/event_type='SECTION_LIBRARY_TAG_ADD' or sys_event/event_type='CITATION_TAG' or sys_event/event_type='CITATION_LIBRARY_TAG_ADD'">
										*&#160;@@the@@&#160;"<xsl:value-of select="value" />"&#160;@@tag_added_to@@&#160;
    									<xsl:if test="link_to_item">
    										<xsl:element name="a">
    											<xsl:attribute name="href">
    												<xsl:value-of select="link_to_item" />
    											</xsl:attribute>
    											<xsl:value-of select="text" />
    										</xsl:element>
    									</xsl:if>
                                        <br/>
                                    </xsl:if>
                                    <xsl:if test="sys_event/event_type='SECTION_LIBRARY_TAG_DELETE' or sys_event/event_type='SECTION_TAG_DELETE' or sys_event/event_type='CITATION_TAG_DELETE' or  sys_event/event_type='CITATION_LIBRARY_TAG_DELETE'">
    									*&#160;@@the@@&#160;"<xsl:value-of select="value" />"&#160;@@tag_removed_from@@&#160;
    									<xsl:if test="link_to_item">
    										<xsl:element name="a">
    											<xsl:attribute name="href">
    												<xsl:value-of select="link_to_item" />
    											</xsl:attribute>
    											<xsl:value-of select="text" />
    										</xsl:element>
    									</xsl:if>
    									<br/>
    								</xsl:if>
    								<xsl:if test="sys_event/event_type='PUBLIC_NOTE'">
										*&#160;"<xsl:value-of select="value" />"&#160;@@was_added_to@@&#160;
    									<xsl:if test="link_to_item">
    										<xsl:element name="a">
    											<xsl:attribute name="href">
    												<xsl:value-of select="link_to_item" />
    											</xsl:attribute>
    											<xsl:value-of select="text" />
    										</xsl:element>
    									</xsl:if>
    									<br/>
    								</xsl:if>
    								<xsl:if test="sys_event/event_type='DUE_DATE'" >
    									*&#160;
    									<xsl:if test="link_to_item">
    										<xsl:element name="a">
    											<xsl:attribute name="href">
    												<xsl:value-of select="link_to_item" />
    											</xsl:attribute>
    											<xsl:value-of select="text" />
    										</xsl:element>
    									</xsl:if>
    									&#160;@@new_due_date@@&#160;
    									<xsl:value-of select="value" />
    									<br/>
    								</xsl:if>
    								<xsl:if test="sys_event/event_type='RL_DISCUSSION'" >
										*&#160;
										<xsl:if test="text !=''">
    									    "<xsl:value-of select="text" />"&#160;
                                        </xsl:if>
                                        @@RL_DISCUSSION@@
                                        <br/>
                                    </xsl:if>
                                    <xsl:if test="link_to_item!= '' and  (sys_event/event_type='ITEM_DECLINED' or sys_event/event_type='BOLK_RIGHTS_CLEARANCE_REJECTED' or sys_event/event_type='BOLK_RIGHTS_CLEARANCE_APPROVED' or  sys_event/event_type='CITATION_ANNOTATION' or sys_event/event_type='NEW_EDITION_AVAILABLE' or sys_event/event_type='ITEM_ADD' or sys_event/event_type='ITEM_COMPLETE' )">
                                        *&#160;
    									<xsl:if test="link_to_item">
    										<xsl:element name="a">
    											<xsl:attribute name="href">
    												<xsl:value-of select="link_to_item" />
    											</xsl:attribute>
    											<xsl:value-of select="value" />
    										</xsl:element>
    									</xsl:if>
                                        <br/>
                                    </xsl:if>
    								<xsl:if test="sys_event/event_type='DISCUSSION'">
    									*&#160;
                                        <xsl:if test="text !=''">
                                       	    "<xsl:value-of select="text" />"&#160;
                                        </xsl:if>
                                        @@was_added_to@@&#160;
    									<xsl:if test="link_to_item">
    										<xsl:element name="a">
    											<xsl:attribute name="href">
    												<xsl:value-of select="link_to_item" />
    											</xsl:attribute>
    											<xsl:value-of select="value" />
    										</xsl:element>
    									</xsl:if>
                                        <br/>
                                    </xsl:if>
                                    <xsl:if test="sys_event/event_type='PUBLISH' or sys_event/event_type='DRAFT'">
                                        *&#160;<xsl:value-of select="sys_event/event_type_display" />
                                    </xsl:if>
                                </xsl:for-each>
                            </p>
						</xsl:for-each>
					</xsl:for-each>
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
