<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    
    <xsl:param name="pathStart">/Volumes/My\ Passport/01_RRSS/</xsl:param>
    <xsl:param name="path2entity">/sidih/menuTop/menu1/menu17/</xsl:param>
    
    <xsl:template match="root">
        <xsl:result-document href="import/move_jpg.txt">
            <xsl:for-each select="object/facs">
                <xsl:variable name="origin_ID" select="parent::object/@path"/>
                <xsl:variable name="entityNumber">
                    <xsl:value-of select="parent::object/@entityID"/>
                </xsl:variable>
                <xsl:variable name="fileNumber">
                    <xsl:value-of select="@fileID"/>
                </xsl:variable>
                <xsl:variable name="fileName" select="."/>
                <xsl:text>mv </xsl:text>
                <xsl:value-of select="concat($pathStart,'files/',$origin_ID,'/',$fileName)"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="concat($pathStart,'import/entity_',$origin_ID,$path2entity,$entityNumber,'/file',$fileNumber,'/',$fileName)"/>
                <xsl:if test="position() != last()">
                    <xsl:text> ; </xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>