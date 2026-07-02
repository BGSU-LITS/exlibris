<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="header.xsl"/>
    <xsl:include href="senderReceiver.xsl"/>
    <xsl:include href="mailReason.xsl"/>
    <xsl:include href="footer.xsl"/>
    <xsl:include href="style.xsl"/>
    <xsl:include href="recordTitle.xsl"/>
    <xsl:variable name="conta1">0</xsl:variable>
    <xsl:variable name="stepType" select="/notification_data/request/work_flow_entity/step_type" />
    <xsl:variable name="externalRequestId" select="/notification_data/external_request_id" />
    <xsl:variable name="externalSystem" select="/notification_data/external_system" />
    <xsl:variable name="isDeposit" select="/notification_data/request/deposit_indicator" />
    <xsl:variable name="isDigitalDocDelivery" select="/notification_data/digital_document_delivery" />
    <xsl:variable name="fileUploaded" select="/notification_data/file_uploaded" />
    <xsl:variable name="deliveryTime" select="/notification_data/delivery_time" />
    <xsl:variable name="loanPeriod" select="/notification_data/loan_period" />
    <xsl:variable name="patronCost" select="/notification_data/patron_cost" />
    <xsl:variable name="isEbook" select="notification_data/resource_sharing_request/book_indication" />
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
                <p>@@your_request@@.</p>
				<p>@@title@@: <xsl:value-of select="notification_data/phys_item_display/title"/></p>
                <xsl:if test="notification_data/terms_of_use != ''">
                    <p>@@terms_of_use@@:<xsl:value-of select="notification_data/terms_of_use"/></p>
                </xsl:if>
                <xsl:if test="false()">
                    <xsl:if test="((notification_data/download_url_local != '' ) or (notification_data/download_url_saml != '') or (notification_data/download_url_cas != ''))" >
                        <p>@@to_see_the_resource@@</p>
                    </xsl:if>
                    <xsl:if test="notification_data/download_url_local != ''">
                        <p>
                            @@for_local_users@@
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="notification_data/download_url_local" />
                                </xsl:attribute>
                                @@click_here@@
                            </a>
                        </p>
                    </xsl:if>
                    <xsl:if test="notification_data/download_url_saml != ''">
                        <p>
                            @@for_saml_users@@
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="notification_data/download_url_saml" />
                                </xsl:attribute>
                                @@click_here@@
                            </a>
                        </p>
                    </xsl:if>
                    <xsl:if test="notification_data/download_url_cas != ''">
                        <p>
                            @@for_cas_users@@
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="notification_data/download_url_cas" />
                                </xsl:attribute>
                                @@click_here@@
                            </a>
                        </p>
                    </xsl:if>
                    <xsl:if test="notification_data/resource_sharing_no_authentication_document_delivery = 'true' and notification_data/download_url_no_authentication != ''">
                        <p>
                            @@without_authentication@@
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="notification_data/download_url_no_authentication" />
                                </xsl:attribute>
                                @@click_here@@
                            </a>
                        </p>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="notification_data/download_url_saml != ''">
                    <p>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="notification_data/download_url_saml" />
                            </xsl:attribute>
                            @@click_here@@
                        </a>
                    </p>
                </xsl:if>
                <xsl:if test="$deliveryTime != '' or ($loanPeriod != '' and $loanPeriod != 0) or $patronCost != ''">
                    <p>
                        @@borrowing_terms@@:
                        <xsl:if test="$deliveryTime != ''">
                            @@deliver_in@@
                            <xsl:value-of select="$deliveryTime"/>
                            <xsl:value-of select="' '" />
                            @@hours@@
                            <xsl:value-of select="' '" />
                        </xsl:if>
                        <xsl:if test="$loanPeriod != '' and $loanPeriod != 0">
                            @@keep_for@@
                            <xsl:value-of select="$loanPeriod"/>
                            <xsl:value-of select="' '" />
                            @@days@@
                            <xsl:value-of select="' '" />
                        </xsl:if>
                        <xsl:if test="$patronCost != ''">
                            @@price@@
                            <xsl:value-of select="$patronCost"/>
                        </xsl:if>
                    </p>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="notification_data/borrowing_document_delivery_max_num_of_views != ''">
                        <p>@@max_num_of_views@@ <xsl:value-of select="notification_data/borrowing_document_delivery_max_num_of_views"/>.</p>
                    </xsl:when>
					<xsl:when test="(notification_data/request/document_delivery_max_num_of_views != '') and ((notification_data/download_url_local != '' ) or (notification_data/download_url_saml != '') or (notification_data/download_url_cas != ''))">
                        <p>@@max_num_of_views@@ <xsl:value-of select="notification_data/request/document_delivery_max_num_of_views"/>.</p>
                    </xsl:when>
                </xsl:choose>
				<xsl:if test="/notification_data/url_list/string">
                    <p>@@attached_are_the_urls@@:</p>
					<xsl:for-each select="/notification_data/url_list/string">
                        <p>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="." />
                                </xsl:attribute>
                                <xsl:value-of select="." />
                            </a>
                        </p>
					</xsl:for-each>
				</xsl:if>
                <xsl:if test="(notification_data/resource_sharing_request/due_date !='') and ($isEbook='true')">
                    <p>@@due_date@@:<xsl:value-of select="notification_data/resource_sharing_request/due_date"/></p>
                </xsl:if>

                <p>
                    <em>Trouble accessing the article?</em> Try this:<br/>
                    Please login to your library account through this link:
                    <a href="https://librarysearch.bgsu.edu/discovery/account?vid=01OHIOLINK_BGSU:BGSU&amp;section=requests">BGSU Library Account</a><br/>
                    Under ‘Requests’ select the download button to the right of the title.
                </p>

                <p>
                    If this resource is not accessible to you, please email:<br/>
                    <a href="mailto:accessibility@libanswers.bgsu.edu">accessibility@libanswers.bgsu.edu</a>,
                    so that we can explore solutions with you.
                </p>

                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
