<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="toWhomIsConcerned">
        <xsl:for-each select="notification_data">
            <p>@@dear@@ <xsl:value-of select="receivers/receiver/user/first_name"/>,</p>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="sincerely">
        <xsl:param name="sincerely"/>
        <xsl:param name="department"/>
        <xsl:if test="$department!=''">
            <p>
                <xsl:if test="$sincerely!=''">
                    <xsl:value-of select="$sincerely"/>,<br/>
                </xsl:if>
                <xsl:value-of select="$department"/>
            </p>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
