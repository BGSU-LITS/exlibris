<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="recordTitle">
        <xsl:value-of select="notification_data/phys_item_display/title"/>
        <xsl:if test="notification_data/phys_item_display/author!=''">
            <br/>@@by@@ <xsl:value-of select="notification_data/phys_item_display/author"/>
        </xsl:if>
        <xsl:if test="notification_data/phys_item_display/issue_level_description!=''">
            <br/>@@description@@ <xsl:value-of select="notification_data/phys_item_display/issue_level_description"/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
