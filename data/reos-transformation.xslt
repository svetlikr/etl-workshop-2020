<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xpath-default-namespace="http://www.loc.gov/MARC21/slim">
  <xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
  <xsl:variable name="prefix">https://svkpk.cz/resource/</xsl:variable>
  <xsl:template match="/">@prefix adms:  &lt;http://www.w3.org/ns/adms#&gt; .
@prefix rdf:  &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
@prefix rdfs:  &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .
@prefix xsd:  &lt;http://www.w3.org/2001/XMLSchema#&gt; .
@prefix dcterms: &lt;http://purl.org/dc/terms/&gt; .
@prefix skos: &lt;http://www.w3.org/2004/02/skos/core#&gt; .
@prefix void: &lt;http://rdfs.org/ns/void#&gt; .
@prefix foaf: &lt;http://xmlns.com/foaf/0.1/&gt; .
@prefix gr: &lt;http://purl.org/goodrelations/v1#&gt; .
@prefix adms: &lt;http://www.w3.org/ns/adms#&gt; .
@prefix schema: &lt;http://schema.org/&gt; .
@prefix cpov: &lt;http://data.europa.eu/m8g/&gt; .
@prefix locn: &lt;http://www.w3.org/ns/locn#&gt; .
@prefix rov: &lt;http://www.w3.org/ns/regorg#&gt; .
@prefix mads: &lt;http://www.loc.gov/mads/rdf/v1#&gt; .
@prefix owl: &lt;http://www.w3.org/2002/07/owl#&gt; .
  
<xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="collection">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="record">
    <xsl:variable name="personIRI" select="concat($prefix,'person/',controlfield[@tag='001'])"/>
    <xsl:variable name="bithPlaceIRI" select="concat($prefix,'place/',replace(datafield[@tag='R02']/subfield[@code='m'],' ','%20'))"/>
    <xsl:variable name="deathPlaceIRI" select="concat($prefix,'place/',replace(datafield[@tag='R03']/subfield[@code='m'],' ','%20'))"/>
    
    <xsl:call-template name="OUTPUT_TYPE_TRIPLE">
      <xsl:with-param name="subject" select="$personIRI"/>
      <xsl:with-param name="type">schema:Person</xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="OUTPUT_DATA_TRIPLE">
      <xsl:with-param name="subject" select="$personIRI"/>
      <xsl:with-param name="triplequote" select="false()"/>
      <xsl:with-param name="predicate">schema:name</xsl:with-param>
      <xsl:with-param name="lang">cs</xsl:with-param>
      <xsl:with-param name="data" select="replace(datafield[@tag='100']/subfield[@code='a'], '(.*), (.*),', '$2 $1')"/>
    </xsl:call-template>

    <xsl:call-template name="OUTPUT_DATA_TRIPLE">
      <xsl:with-param name="subject" select="$personIRI"/>
      <xsl:with-param name="triplequote" select="false()"/>
      <xsl:with-param name="predicate">schema:givenName</xsl:with-param>
      <xsl:with-param name="lang">cs</xsl:with-param>
      <xsl:with-param name="data" select="replace(datafield[@tag='100']/subfield[@code='a'], '(.*), (.*),', '$1')"/>
    </xsl:call-template>

    <xsl:call-template name="OUTPUT_DATA_TRIPLE">
      <xsl:with-param name="subject" select="$personIRI"/>
      <xsl:with-param name="triplequote" select="false()"/>
      <xsl:with-param name="predicate">schema:familyName</xsl:with-param>
      <xsl:with-param name="lang">cs</xsl:with-param>
      <xsl:with-param name="data" select="replace(datafield[@tag='100']/subfield[@code='a'], '(.*), (.*),', '$2')"/>
    </xsl:call-template>

    <xsl:call-template name="OUTPUT_DATA_TRIPLE">
      <xsl:with-param name="subject" select="$personIRI"/>
      <xsl:with-param name="triplequote" select="false()"/>
      <xsl:with-param name="predicate">schema:birthDate</xsl:with-param>
      <xsl:with-param name="type">xsd:date</xsl:with-param>
      <xsl:with-param name="data" select="replace(datafield[@tag='KDN']/subfield[@code='a'], '(\d{4})(\d{2})(\d{2})', '$1-$2-$3')"/>
    </xsl:call-template>

    <xsl:call-template name="OUTPUT_DATA_TRIPLE">
      <xsl:with-param name="subject" select="$personIRI"/>
      <xsl:with-param name="triplequote" select="false()"/>
      <xsl:with-param name="predicate">schema:deathDate</xsl:with-param>
      <xsl:with-param name="type">xsd:date</xsl:with-param>
      <xsl:with-param name="data" select="replace(datafield[@tag='KDU']/subfield[@code='a'], '(\d{4})(\d{2})(\d{2})', '$1-$2-$3')"/>
    </xsl:call-template>

    <xsl:call-template name="OUTPUT_DATA_TRIPLE">
      <xsl:with-param name="subject" select="$personIRI"/>
      <xsl:with-param name="triplequote" select="false()"/>
      <xsl:with-param name="predicate">dcterms:subject</xsl:with-param>
      <xsl:with-param name="lang">cs</xsl:with-param>
      <xsl:with-param name="data" select="datafield[@tag='R06']/subfield[@code='a']"/>
    </xsl:call-template>
    
    <xsl:if test="datafield[@tag='R02']/subfield[@code='m']">
      <xsl:call-template name="OUTPUT_OBJECT_TRIPLE">
        <xsl:with-param name="subject" select="$personIRI"/>
        <xsl:with-param name="predicate">schema:birthPlace</xsl:with-param>
        <xsl:with-param name="object" select="$deathPlaceIRI"/>
      </xsl:call-template>
      <xsl:call-template name="OUTPUT_TYPE_TRIPLE">
        <xsl:with-param name="subject" select="$bithPlaceIRI"/>
        <xsl:with-param name="type">schema:Place</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="OUTPUT_DATA_TRIPLE">
        <xsl:with-param name="subject" select="$bithPlaceIRI"/>
        <xsl:with-param name="triplequote" select="false()"/>
        <xsl:with-param name="predicate">schema:name</xsl:with-param>
        <xsl:with-param name="lang">cs</xsl:with-param>
        <xsl:with-param name="data" select="datafield[@tag='R02']/subfield[@code='m']"/>
      </xsl:call-template>
      <xsl:call-template name="OUTPUT_DATA_TRIPLE">
        <xsl:with-param name="subject" select="$bithPlaceIRI"/>
        <xsl:with-param name="triplequote" select="false()"/>
        <xsl:with-param name="predicate">schema:containedInPlace</xsl:with-param>
        <xsl:with-param name="lang">cs</xsl:with-param>
        <xsl:with-param name="data" select="datafield[@tag='R02']/subfield[@code='o']"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="datafield[@tag='R03']/subfield[@code='m']">
      <xsl:call-template name="OUTPUT_OBJECT_TRIPLE">
        <xsl:with-param name="subject" select="$personIRI"/>
        <xsl:with-param name="predicate">schema:deathPlace</xsl:with-param>
        <xsl:with-param name="object" select="$deathPlaceIRI"/>
      </xsl:call-template>
      <xsl:call-template name="OUTPUT_TYPE_TRIPLE">
        <xsl:with-param name="subject" select="$deathPlaceIRI"/>
        <xsl:with-param name="type">schema:Place</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="OUTPUT_DATA_TRIPLE">
        <xsl:with-param name="subject" select="$deathPlaceIRI"/>
        <xsl:with-param name="triplequote" select="false()"/>
        <xsl:with-param name="predicate">schema:name</xsl:with-param>
        <xsl:with-param name="lang">cs</xsl:with-param>
        <xsl:with-param name="data" select="datafield[@tag='R03']/subfield[@code='m']"/>
      </xsl:call-template>
      <xsl:call-template name="OUTPUT_DATA_TRIPLE">
        <xsl:with-param name="subject" select="$deathPlaceIRI"/>
        <xsl:with-param name="triplequote" select="false()"/>
        <xsl:with-param name="predicate">schema:containedInPlace</xsl:with-param>
        <xsl:with-param name="lang">cs</xsl:with-param>
        <xsl:with-param name="data" select="datafield[@tag='R03']/subfield[@code='o']"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:for-each select="datafield[@tag='R05']">
      <xsl:variable name="workPlaceIRI" select="concat($prefix,'place/',replace(./subfield[@code='m'],' ','%20'))"/>
      <xsl:call-template name="OUTPUT_OBJECT_TRIPLE">
        <xsl:with-param name="subject" select="$personIRI"/>
        <xsl:with-param name="predicate">schema:workLocation</xsl:with-param>
        <xsl:with-param name="object" select="$workPlaceIRI"/>
      </xsl:call-template>
      <xsl:call-template name="OUTPUT_TYPE_TRIPLE">
        <xsl:with-param name="subject" select="$workPlaceIRI"/>
        <xsl:with-param name="type">schema:Place</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="OUTPUT_DATA_TRIPLE">
        <xsl:with-param name="subject" select="$workPlaceIRI"/>
        <xsl:with-param name="triplequote" select="false()"/>
        <xsl:with-param name="predicate">schema:name</xsl:with-param>
        <xsl:with-param name="lang">cs</xsl:with-param>
        <xsl:with-param name="data">
          <xsl:value-of select="./subfield[@code='m']"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="OUTPUT_DATA_TRIPLE">
        <xsl:with-param name="subject" select="$workPlaceIRI"/>
        <xsl:with-param name="triplequote" select="false()"/>
        <xsl:with-param name="predicate">schema:containedInPlace</xsl:with-param>
        <xsl:with-param name="lang">cs</xsl:with-param>
        <xsl:with-param name="data">
          <xsl:value-of select="./subfield[@code='o']"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>

    <xsl:call-template name="OUTPUT_DATA_TRIPLE">
      <xsl:with-param name="subject" select="$personIRI"/>
      <xsl:with-param name="triplequote" select="false()"/>
      <xsl:with-param name="predicate">schema:disambiguatingDescription</xsl:with-param>
      <xsl:with-param name="lang">cs</xsl:with-param>
      <xsl:with-param name="data" select="datafield[@tag='678']/subfield[@code='a']"/>
    </xsl:call-template>

    <xsl:call-template name="OUTPUT_DATA_TRIPLE">
      <xsl:with-param name="subject" select="$personIRI"/>
      <xsl:with-param name="triplequote" select="false()"/>
      <xsl:with-param name="predicate">mads:Source</xsl:with-param>
      <xsl:with-param name="lang">cs</xsl:with-param>
      <xsl:with-param name="data" select="datafield[@tag='670']/subfield[@code='a']"/>
    </xsl:call-template>

    <xsl:if test="datafield[@tag='100']/subfield[@code='7']">
      <xsl:call-template name="OUTPUT_DATA_TRIPLE">
        <xsl:with-param name="subject" select="$personIRI"/>
        <xsl:with-param name="triplequote" select="false()"/>
        <xsl:with-param name="predicate">mads:isIdentifiedByAutority</xsl:with-param>
        <xsl:with-param name="data" select="concat('https://viaf.org/viaf/sourceID/NKC|',datafield[@tag='100']/subfield[@code='7'],'#skos:Concept')"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>
  <!--#################################################################### SUPPORT TEMPLATES ###################################################################################-->
  <xsl:template name="OUTPUT_IDENTIFIER">
    <xsl:param name="conceptURI"/>
    <xsl:param name="conceptURI_NUI"/>
    <xsl:param name="notation"/>
    <xsl:param name="agencyName"/>
    <xsl:param name="agencyURI"/>
    <xsl:param name="schemeName"/>
    <xsl:param name="schemeURI"/>
    <!--<xsl:variable name="identifierURI" select="concat($conceptURI, '/identifier/', lower-case($schemeName), '/', $notation[1])"/>-->
    <xsl:variable name="identifierURI_NUI" select="concat($conceptURI_NUI, '/identifier/', lower-case($schemeName), '/', $notation[1])"/>
    <!--
    <xsl:call-template name="OUTPUT_SAME_AS_TRIPLE">
      <xsl:with-param name="subject" select="$identifierURI" />
      <xsl:with-param name="object" select="$identifierURI_NUI" />
    </xsl:call-template>
-->
    <xsl:call-template name="OUTPUT_OBJECT_TRIPLE">
      <xsl:with-param name="subject" select="$conceptURI"/>
      <xsl:with-param name="predicate">adms:identifier</xsl:with-param>
      <xsl:with-param name="object" select="$identifierURI_NUI"/>
    </xsl:call-template>
    <xsl:call-template name="OUTPUT_TYPE_TRIPLE">
      <xsl:with-param name="subject" select="$identifierURI_NUI"/>
      <xsl:with-param name="type">adms:Identifier</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="OUTPUT_DATA_TRIPLE">
      <xsl:with-param name="subject" select="$identifierURI_NUI"/>
      <xsl:with-param name="predicate">skos:notation</xsl:with-param>
      <xsl:with-param name="data" select="$notation"/>
    </xsl:call-template>
    <xsl:call-template name="OUTPUT_DATA_TRIPLE">
      <xsl:with-param name="subject" select="$identifierURI_NUI"/>
      <xsl:with-param name="predicate">adms:schemeAgency</xsl:with-param>
      <xsl:with-param name="data" select="$agencyName"/>
    </xsl:call-template>
    <xsl:call-template name="OUTPUT_OBJECT_TRIPLE">
      <xsl:with-param name="subject" select="$identifierURI_NUI"/>
      <xsl:with-param name="predicate">dcterms:creator</xsl:with-param>
      <xsl:with-param name="object" select="$agencyURI"/>
    </xsl:call-template>
    <xsl:call-template name="OUTPUT_OBJECT_TRIPLE">
      <xsl:with-param name="subject" select="$identifierURI_NUI"/>
      <xsl:with-param name="predicate">dcterms:type</xsl:with-param>
      <xsl:with-param name="object" select="$schemeURI"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="OUTPUT_OBJECT_TRIPLE">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <xsl:param name="object"/>
    <xsl:if test="$object">
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="$subject"/>
      <xsl:text>&gt; </xsl:text>
      <xsl:value-of select="$predicate"/>
      <xsl:text> &lt;</xsl:text>
      <xsl:value-of select="$object"/>
      <xsl:text>&gt; .
</xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template name="OUTPUT_OBJECT_CURIE_TRIPLE">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <xsl:param name="object"/>
    <xsl:if test="$object">
      <xsl:value-of select="$subject"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$predicate"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$object"/>
      <xsl:text> .
</xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template name="OUTPUT_TYPE_TRIPLE">
    <xsl:param name="subject"/>
    <xsl:param name="type"/>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="$subject"/>
    <xsl:text>&gt; a </xsl:text>
    <xsl:value-of select="$type"/>
    <xsl:text> .
</xsl:text>
  </xsl:template>
  <xsl:template name="OUTPUT_TYPE_CURIE_TRIPLE">
    <xsl:param name="subject"/>
    <xsl:param name="type"/>
    <xsl:value-of select="$subject"/>
    <xsl:text> a </xsl:text>
    <xsl:value-of select="$type"/>
    <xsl:text> .
</xsl:text>
  </xsl:template>
  <xsl:template name="OUTPUT_SAME_AS_TRIPLE">
    <xsl:param name="subject"/>
    <xsl:param name="object"/>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="$subject"/>
    <xsl:text>&gt; owl:sameAs </xsl:text>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="$object"/>
    <xsl:text>&gt; .
</xsl:text>
  </xsl:template>
  <xsl:template name="OUTPUT_DATA_TRIPLE">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <xsl:param name="data"/>
    <xsl:param name="type"/>
    <xsl:param name="lang"/>
    <xsl:param name="triplequote"/>
    <xsl:for-each select="$data">
      <xsl:variable name="data-item" select="replace(replace(replace(., '\\', '\\\\'), '&quot;', '\\&quot;'),'\n', ' ')"/>
      <xsl:if test="string-length($data-item) &gt; 0">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="$subject"/>
        <xsl:text>&gt; </xsl:text>
        <xsl:value-of select="$predicate"/>
        <xsl:if test="$triplequote=true()">
          <xsl:text> """</xsl:text>
        </xsl:if>
        <xsl:if test="$triplequote=false()">
          <xsl:text> "</xsl:text>
        </xsl:if>
        <xsl:value-of select="$data-item"/>
        <xsl:if test="$triplequote=true()">
          <xsl:text>"""</xsl:text>
        </xsl:if>
        <xsl:if test="$triplequote=false()">
          <xsl:text>"</xsl:text>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="$lang">
            <xsl:text>@</xsl:text>
            <xsl:value-of select="$lang"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="$type">
              <xsl:text>^^</xsl:text>
              <xsl:value-of select="$type"/>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text> .
</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="OUTPUT_DATA_CURIE_TRIPLE">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <xsl:param name="data"/>
    <xsl:param name="type"/>
    <xsl:param name="lang"/>
    <xsl:param name="triplequote"/>
    <xsl:for-each select="$data">
      <xsl:variable name="data-item" select="replace(replace(replace(., '\\', '\\\\'), '&quot;', '\\&quot;'),'\n', ' ')"/>
      <xsl:if test="string-length($data-item) &gt; 0">
        <xsl:value-of select="$subject"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$predicate"/>
        <xsl:if test="$triplequote=true()">
          <xsl:text> """</xsl:text>
        </xsl:if>
        <xsl:if test="$triplequote=false()">
          <xsl:text> "</xsl:text>
        </xsl:if>
        <xsl:value-of select="$data-item"/>
        <xsl:if test="$triplequote=true()">
          <xsl:text>"""</xsl:text>
        </xsl:if>
        <xsl:if test="$triplequote=false()">
          <xsl:text>"</xsl:text>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="$lang">
            <xsl:text>@</xsl:text>
            <xsl:value-of select="$lang"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="$type">
              <xsl:text>^^</xsl:text>
              <xsl:value-of select="$type"/>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text> .
</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="OUTPUT_BOOL_CURIE_TRIPLE">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <xsl:param name="data"/>
    <xsl:for-each select="$data">
      <xsl:variable name="data-item" select="replace(replace(replace(., '\\', '\\\\'), '&quot;', '\\&quot;'),'\n', ' ')"/>
      <xsl:if test="string-length($data-item) &gt; 0">
        <xsl:value-of select="$subject"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$predicate"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$data-item"/>
        <xsl:text> .
</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="*|@*"/>
</xsl:stylesheet>