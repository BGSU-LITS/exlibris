<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="salutation"></xsl:template>
    <xsl:template name="lastFooter">
        <div style="margin:0 auto 0 0;max-width:610px;padding:0 6px">
            <div style="line-height:1.7;margin:0;padding:20px 0 10px 0;text-align:center;word-break:break-word">
                <xsl:call-template name="contactUs"/>
                |
                <xsl:call-template name="myAccount"/>
            </div>
            <div style="border-top:solid 1px #f6f6f6;color:#666;font-size:11px;line-height:1.7;margin:0;padding:15px 0 0 20px;text-align:center;word-break:break-word">
                University Libraries | 1001 East Wooster St. Bowling Green, Ohio 43403
            </div>
            <xsl:if test="notification_data/general_data/letter_name!=''">
                <div style="color:#ccc;font-size:10px;line-height:1.5;margin:0;padding:0;text-align:center;word-break-break-word">
                    <xsl:value-of select="notification_data/general_data/letter_name"/>
                    <xsl:if test="notification_data/general_data/letter_type!=''">
                        (<xsl:value-of select="notification_data/general_data/letter_type"/>)
                    </xsl:if>
                </div>
            </xsl:if>
        </div>
    </xsl:template>
    <xsl:template name="contactUs">
        <a href="@@email_contact_us@@" style="color:#DF3602;font-weight:700;text-decoration:underline;text-decoration-color:#F5C163;text-decoration-thickness:1px;text-underline-offset:2px"><img alt="" src="https://www.bgsu.edu/content/dam/emails/Library/2024/askus-orange.png" style="border:0;vertical-align:bottom" width="150"/><br/>@@contact_us@@</a>
    </xsl:template>
    <xsl:template name="myAccount">
        <a href="@@email_my_account@@" style="color:#DF3602;font-weight:700;text-decoration:underline;text-decoration-color:#F5C163;text-decoration-thickness:1px;text-underline-offset:2px">@@my_account@@</a>
    </xsl:template>
</xsl:stylesheet>
