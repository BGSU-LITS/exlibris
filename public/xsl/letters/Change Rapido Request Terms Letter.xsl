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

			    <table role='presentation'  cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
							<h3>@@header@@</h3>
						</td>
					</tr>
				</table>

						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<tr>
								<td>
									@@start@@
								</td>
							</tr>
						</table>

                        <br/>

						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss"/>
								<!-- style.xsl -->
							</xsl:attribute>
							<xsl:if test="notification_data/request/external_request_id !=''">
								<tr>
									<td>
										<strong> @@requestId@@: </strong>
										<xsl:value-of select="notification_data/request/external_request_id"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/title !=''">
								<tr>
									<td>
										<strong> @@title@@: </strong>
										<xsl:value-of select="notification_data/request/title"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/create_date_str !=''">
								<tr>
									<td>
										<strong> @@requestDate@@: </strong>
										<xsl:value-of select="notification_data/request/create_date_str"/>
									</td>
								</tr>
							</xsl:if>
						</table>

						<br/>

						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
								<xsl:if test="notification_data/old_terms_exist='true'">
									<tr>
										<td>
											<xsl:if test="notification_data/old_delivey_time != '' and notification_data/old_loan_period != ''">
												@@from@@
												<xsl:value-of select="notification_data/old_delivey_time" />
												<xsl:if test="notification_data/old_offer_format = 'Digital'">
													@@keepForEbook@@
												</xsl:if>
												<xsl:if test="notification_data/old_offer_format != 'Digital'">
													@@keepFor@@
												</xsl:if>
												<xsl:value-of select="notification_data/old_loan_period" />
												@@days@@
											</xsl:if>
											<xsl:if test="notification_data/old_delivey_time = ''">
												@@fromRota@@
												@@deliveryNotExist@@
												<xsl:value-of select="notification_data/old_loan_period" />
												@@days@@
											</xsl:if>
											<xsl:if test="notification_data/old_loan_period = ''">
												@@from@@
												<xsl:value-of select="notification_data/old_delivey_time" />
												@@loanPeriodNotExist@@
											</xsl:if>
											<xsl:if test="notification_data/old_cost !=''">
												@@costToPatron@@
												<xsl:value-of select="notification_data/old_cost" />
												<xsl:value-of select="' '" />
												<xsl:value-of select="notification_data/currency" />
											</xsl:if>
											<xsl:if test="notification_data/old_cost ='' and notification_data/new_cost !=''">
												@@costIsUnkown@@
											</xsl:if>
											<xsl:if test="notification_data/offer_format_changed ='true' and notification_data/old_offer_format ='Digital'">
												@@digital@@
												@@format@@
											</xsl:if>
											<xsl:if test="notification_data/offer_format_changed ='true' and notification_data/old_offer_format ='Physical'">
												@@physical@@
												@@format@@
											</xsl:if>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/old_terms_exist='false'">
									<tr>
										<td>
											@@unknownTerms@@
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/new_terms_exist='true'">
									<tr>
										<td>
											<xsl:if test="notification_data/ngrs_request/delivery_time != '0' and notification_data/ngrs_request/loan_period != '0'">
												@@to@@
												<xsl:value-of select="notification_data/ngrs_request/delivery_time" />
												<xsl:if test="notification_data/new_offer_format = 'Digital'">
													@@keepForEbook@@
												</xsl:if>
												<xsl:if test="notification_data/new_offer_format != 'Digital'">
													@@keepFor@@
												</xsl:if>
												<xsl:value-of select="notification_data/ngrs_request/loan_period" />
												@@days@@
											</xsl:if>
											<xsl:if test="notification_data/ngrs_request/delivery_time = '0'">
												@@toRota@@
												@@deliveryNotExist@@
												<xsl:value-of select="notification_data/ngrs_request/loan_period" />
												@@days@@
											</xsl:if>
											<xsl:if test="notification_data/ngrs_request/loan_period = '0'">
												@@to@@
												<xsl:value-of select="notification_data/ngrs_request/delivery_time" />
												@@loanPeriodNotExist@@
											</xsl:if>
											<xsl:if test="notification_data/new_cost !=''">
												@@costToPatron@@
												<xsl:value-of select="notification_data/new_cost" />
												<xsl:value-of select="' '" />
												<xsl:value-of select="notification_data/currency" />
											</xsl:if>
											<xsl:if test="notification_data/new_cost ='' and notification_data/old_cost !=''">
												@@costIsUnkown@@
											</xsl:if>
											<xsl:if test="notification_data/offer_format_changed ='true' and notification_data/new_offer_format ='Digital'">
												@@digital@@
												@@format@@
											</xsl:if>
											<xsl:if test="notification_data/offer_format_changed ='true' and notification_data/new_offer_format ='Physical'">
												@@physical@@
												@@format@@
											</xsl:if>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/new_terms_exist='false'">
									<tr>
										<td>
											@@toUnknownTerms@@
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/default_pickup_location != '' and notification_data/preferred_library != '' and notification_data/preferred_inst != ''">
									<tr>
										<td>
											<strong> @@pickupLocationChanged@@ </strong>
											<strong><xsl:value-of select="notification_data/preferred_inst"/>-</strong>
											<strong><xsl:value-of select="notification_data/preferred_library"/></strong>
											<strong> @@defaultPickupLocation@@ </strong>
											<strong><xsl:value-of select="notification_data/default_pickup_location"/></strong>
										</td>
									</tr>
								</xsl:if>
						</table>
						<br/>
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<xsl:if test="notification_data/new_terms_exist='true'">
								<tr>
									<td>
										@@termsChange@@
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/new_terms_exist='false'">
									<tr>
										<td>
											@@prevTermsNoValid@@
											<br/>
											@@weWillUpdate@@
										</td>
									</tr>
							</xsl:if>
						</table>
						<br/>

						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<xsl:if test="notification_data/new_pickup_date !=''">
								<tr>
									<td>
										@@newPickupDate@@:
										<xsl:value-of select="notification_data/new_pickup_date"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/new_due_date !=''">
								<tr>
									<td>
										@@newDueDate@@:
										<xsl:value-of select="notification_data/new_due_date"/>
									</td>
								</tr>
							</xsl:if>
						</table>

						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<xsl:if test="notification_data/new_delivery_date!=''">
								<tr>
									<td>
										@@newDeliveryDate@@:
										<xsl:value-of select="notification_data/new_delivery_date"/>
									</td>
								</tr>
							</xsl:if>
						</table>

						<br/>

						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<tr>
								<td>
									@@end@@
								</td>
							</tr>
						</table>

                <xsl:call-template name="sincerely">
                    <xsl:with-param name="sincerely">@@signature@@</xsl:with-param>
                    <xsl:with-param name="department">
                        <xsl:value-of select="notification_data/organization_unit/name"/>
                        <xsl:if test="notification_data/organization_unit/address/line1!=''">
                            <br/><xsl:value-of select="notification_data/organization_unit/address/line1"/>
                        </xsl:if>
                        <xsl:if test="notification_data/organization_unit/address/line2!=''">
                            <br/><xsl:value-of select="notification_data/organization_unit/address/line2"/>
                        </xsl:if>
                        <xsl:if test="notification_data/organization_unit/address/line3!=''">
                            <br/><xsl:value-of select="notification_data/organization_unit/address/line3"/>
                        </xsl:if>
                        <xsl:if test="notification_data/organization_unit/address/line4!=''">
                            <br/><xsl:value-of select="notification_data/organization_unit/address/line4"/>
                        </xsl:if>
                        <xsl:if test="notification_data/organization_unit/address/line5!=''">
                            <br/><xsl:value-of select="notification_data/organization_unit/address/line5"/>
                        </xsl:if>
                        <xsl:if test="notification_data/organization_unit/address/city!=''">
                            <br/><xsl:value-of select="notification_data/organization_unit/address/city"/>
                        </xsl:if>
                        <xsl:if test="notification_data/organization_unit/address/country!=''">
                            <br/><xsl:value-of select="notification_data/organization_unit/address/country"/>
                        </xsl:if>
                    </xsl:with-param>
                </xsl:call-template><!-- mailReason.xsl -->
                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
