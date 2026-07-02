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
                <p>@@requested@@:</p>
                <p>
                    <xsl:if test="notification_data/request/display/material_type !=''">
                        <strong> @@format@@:  </strong>
                        <xsl:value-of select="notification_data/request/display/material_type" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/title !=''">
                        <strong> @@title@@: </strong>
                        <xsl:value-of select="notification_data/request/display/title" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/journal_title !=''">
                        <strong> @@journal_title@@: </strong>
                        <xsl:value-of select="notification_data/request/display/journal_title" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/author !=''">
                        <strong> @@author@@: </strong>
                        <xsl:value-of select="notification_data/request/display/author" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/autho_initials !=''">
                        <strong> @@author_initials@@: </strong>
                        <xsl:value-of select="notification_data/request/display/autho_initials" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/publisher !=''">
                        <strong> @@publisher@@: </strong>
                        <xsl:value-of select="notification_data/request/display/publisher" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/place_of_publication !=''">
                        <strong> @@place_of_publication@@: </strong>
                        <xsl:value-of select="notification_data/request/display/place_of_publication" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/publication_date !=''">
                        <strong> @@publication_date@@: </strong>
                        <xsl:value-of select="notification_data/request/display/publication_date" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/year !=''">
                        <strong> @@year@@: </strong>
                        <xsl:value-of select="notification_data/request/display/year" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/edition !=''">
                        <strong> @@edition@@: </strong>
                        <xsl:value-of select="notification_data/request/display/edition" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/call_number !=''">
                        <strong> @@call_number@@: </strong>
                        <xsl:value-of select="notification_data/request/display/call_number" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/volume !=''">
                        <strong> @@volume@@: </strong>
                        <xsl:value-of select="notification_data/request/display/volume" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/issue !=''">
                        <strong> @@issue@@: </strong>
                        <xsl:value-of select="notification_data/request/display/issue" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/additional_person_name !=''">
                        <strong> @@additional_person_name@@: </strong>
                        <xsl:value-of select="notification_data/request/display/additional_person_name" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/source !=''">
                        <strong> @@source@@: </strong>
                        <xsl:value-of select="notification_data/request/display/source" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/series_title_number !=''">
                        <strong> @@series_title_number@@: </strong>
                        <xsl:value-of select="notification_data/request/display/series_title_number" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/isbn !=''">
                        <strong> @@isbn@@: </strong>
                        <xsl:value-of select="notification_data/request/display/isbn" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/issn !=''">
                        <strong> @@issn@@: </strong>
                        <xsl:value-of select="notification_data/request/display/issn" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/doi !=''">
                        <strong> @@doi@@: </strong>
                        <xsl:value-of select="notification_data/request/display/doi" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/pmid !=''">
                        <strong> @@pmid@@: </strong>
                        <xsl:value-of select="notification_data/request/display/pmid" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/note !=''">
                        <strong> @@note@@: </strong>
                        <xsl:value-of select="notification_data/request/display/note" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/chapter !=''">
                        <strong> @@chapter@@: </strong>
                        <xsl:value-of select="notification_data/request/display/chapter" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/volume_bk !=''">
                        <strong> @@volume@@: </strong>
                        <xsl:value-of select="notification_data/request/display/volume_bk" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/part !=''">
                        <strong> @@part@@: </strong>
                        <xsl:value-of select="notification_data/request/display/part" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/pages !=''">
                        <strong> @@pages@@: </strong>
                        <xsl:value-of select="notification_data/request/display/pages" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/start_page !=''">
                        <strong> @@start_page@@: </strong>
                        <xsl:value-of select="notification_data/request/display/start_page" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/display/end_page !=''">
                        <strong> @@end_page@@: </strong>
                        <xsl:value-of select="notification_data/request/display/end_page" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/note !=''">
                        <strong> @@request_note@@: </strong>
                        <xsl:value-of select="notification_data/request/note" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/general_data/current_date !=''">
                        <strong> @@date@@: </strong>
                        <xsl:value-of select="notification_data/general_data/current_date" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/external_request_id !=''">
                        <strong> @@request_id@@: </strong>
                        <xsl:value-of select="notification_data/request/external_request_id" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/format_display !=''">
                        <strong> @@request_format@@: </strong>
                        <xsl:value-of select="notification_data/request/format_display" />
                        <br/>
                    </xsl:if>
                    <xsl:if test="notification_data/request/max_fee !=''">
                        <strong>@@maximum_fee@@: </strong>
                        <xsl:value-of select="notification_data/request/max_fee" />
                        <br/>
                    </xsl:if>
                </p>
                <xsl:if test="notification_data/query_note !=''">
                    <p>
                        <xsl:value-of select="notification_data/query_note" />
                    </p>
                </xsl:if>
                <xsl:call-template name="sincerely">
                    <xsl:with-param name="sincerely">@@Type_1_Sincerely@@</xsl:with-param>
                    <xsl:with-param name="department"><xsl:value-of select="notification_data/library/name" /></xsl:with-param>
                </xsl:call-template><!-- mailReason.xsl -->
                <p>
                    <xsl:if test="notification_data/library/address/line1 !=''">
                        <xsl:value-of select="notification_data/library/address/line1" /><br/>
                    </xsl:if>
                    <xsl:if test="notification_data/library/address/line2 !=''">
                        <xsl:value-of select="notification_data/library/address/line2" /><br/>
                    </xsl:if>
                    <xsl:if test="notification_data/library/address/line3 !=''">
                        <xsl:value-of select="notification_data/library/address/line3" /><br/>
                    </xsl:if>
                    <xsl:if test="notification_data/library/address/line4 !=''">
                        <xsl:value-of select="notification_data/library/address/line4" /><br/>
                    </xsl:if>
                    <xsl:if test="notification_data/library/address/line5 !=''">
                        <xsl:value-of select="notification_data/library/address/line5" /><br/>
                    </xsl:if>
                    <xsl:if test="notification_data/library/address/city !=''">
                        <xsl:value-of select="notification_data/library/address/city" />
                        <xsl:if test="notification_data/library/address/state_province !=''">,
                            <xsl:value-of select="notification_data/library/address/state_province" />
                        </xsl:if>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="notification_data/library/address/postal_code" /><br/>
                    </xsl:if>
                    <xsl:if test="notification_data/library/address/country_display !=''">
                        <xsl:value-of select="notification_data/library/address/country_display" /><br/>
                    </xsl:if>
                    <xsl:if test="notification_data/signature_email !=''">
                        <a>
                            <xsl:attribute name="href">
                                mailto:<xsl:value-of select="notification_data/signature_email"/>
                            </xsl:attribute>
                            <xsl:value-of select="notification_data/signature_email" />
                        </a>
                    </xsl:if>
                </p>
                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
