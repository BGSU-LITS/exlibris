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

                <p>@@please_find_below@@</p>
                
				<xsl:if test="notification_data/non_active_requests/ful_request_interpated">
				    <div class="indent">
                        <div class="h1">@@not_active@@</div>
                        <p>@@not_active_description@@</p>
                    </div>
                	<table>
						<tr>
							<th>@@type@@</th>
							<th>@@title@@</th>
							<th>@@author@@</th>
							<th>@@place_in_queue@@</th>
							<th>@@pickup_location@@</th>
						</tr>
						<xsl:for-each select="notification_data/non_active_requests/ful_request_interpated">
							<tr>
								<td><xsl:value-of select="request_type_display"/></td>
								<td><xsl:value-of select="title_display"/></td>
								<td><xsl:value-of select="author_display"/></td>
								<td><xsl:value-of select="place_in_queue"/></td>
								<td><xsl:value-of select="pickup_location_display"/></td>
							</tr>
						</xsl:for-each>
					</table>
				</xsl:if>
				
				<xsl:if test="notification_data/process_requests/ful_request_interpated">
				    <div class="indent">
                        <div class="h1">@@in_process@@</div>
                        <p>@@in_process_description@@</p>
                    </div>
                	<table>
						<tr>
							<th>@@type@@</th>
							<th>@@title@@</th>
							<th>@@author@@</th>
							<th>@@status@@</th>
							<th>@@pickup_location@@</th>
						</tr>
						<xsl:for-each select="notification_data/process_requests/ful_request_interpated">
							<tr>
								<td><xsl:value-of select="request_type_display"/></td>
								<td><xsl:value-of select="title_display"/></td>
								<td><xsl:value-of select="author_display"/></td>
								<td><xsl:value-of select="request_status_display"/></td>
								<td><xsl:value-of select="pickup_location_display"/></td>
							</tr>
						</xsl:for-each>
					</table>						
				</xsl:if>

				<xsl:if test="notification_data/hold_shelf_requests/ful_request_interpated">
				    <div class="indent">
                        <div class="h1">@@on_hold_shelf@@</div>
                        <p>@@on_hold_shelf_description@@</p>
                    </div>
                	<table>
						<tr>
							<th>@@type@@</th>
							<th>@@title@@</th>
							<th>@@author@@</th>
							<th>@@status@@</th>
							<th>@@pickup_location@@</th>
						</tr>
						<xsl:for-each select="notification_data/hold_shelf_requests/ful_request_interpated">
							<tr>
								<td><xsl:value-of select="request_type_display"/></td>
								<td><xsl:value-of select="title_display"/></td>
								<td><xsl:value-of select="author_display"/></td>
								<td><xsl:value-of select="request_status_display"/></td>
								<td><xsl:value-of select="pickup_location_display"/></td>
							</tr>
						</xsl:for-each>
					</table>						
				</xsl:if>

                <xsl:call-template name="lastFooter"/><!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
        