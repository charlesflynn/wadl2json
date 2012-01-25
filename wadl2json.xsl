<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:html="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml">
  <xsl:template match="wadl:application"><!--
 -->{"resources": [<xsl:apply-templates select="wadl:resources/wadl:resource"/>]}
  </xsl:template>

  <xsl:template match="wadl:resources/wadl:resource">
    <xsl:variable name='rootpath' select="@path"/>
    <xsl:apply-templates select="wadl:resource">
      <xsl:with-param name='parentpath' select='$rootpath'/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="wadl:resource">
    <xsl:param name='parentpath'/>
    <xsl:variable name='path' select="@path"/>
    <xsl:apply-templates select="wadl:resource">
      <xsl:with-param name='parentpath' select='concat($parentpath, "/", $path)'/>
    </xsl:apply-templates>{"parentpath": "<xsl:value-of select='$parentpath'/>",
"path": "<xsl:value-of select='$path'/>", "methods": [<xsl:apply-templates select="wadl:method">
        <xsl:with-param name='parentpath' select='$parentpath'/>
        <xsl:with-param name='path' select='$path'/>
      </xsl:apply-templates>]},</xsl:template>    

  <xsl:template match="wadl:method">
    <xsl:param name='parentpath'/>
    <xsl:param name='path'/>{"name": "<xsl:value-of select='@name'/>", "id": "<xsl:value-of select='@id'/>",<!--
  -->"request": {"representation": {<xsl:apply-templates select='wadl:request/wadl:representation'/>}},<!--
   --> "response": {"mediaTypes": [<xsl:apply-templates select='wadl:response/wadl:representation'/>]}<!--
    -->},</xsl:template>
  
  <xsl:template match="wadl:request/wadl:representation">"mediaType": {<!--
  -->"name": "<xsl:value-of select='@mediaType'/>", <!--
      -->"params": {<xsl:apply-templates select="wadl:param"/>}}</xsl:template>

  <xsl:template match="wadl:param">"param": {<!--
  -->"name": "<xsl:value-of select='@name'/>",<!--
  -->"style": "<xsl:value-of select='@style'/>",<!--
  -->"type": "<xsl:value-of select='@type'/>",<!--
  -->"default": "<xsl:value-of select='@default'/>"<!--
  -->},</xsl:template>

  <xsl:template match="wadl:response/wadl:representation">"<xsl:value-of select='@mediaType'/>",</xsl:template>

</xsl:stylesheet>
