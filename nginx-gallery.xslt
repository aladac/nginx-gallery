<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" />
  <xsl:template name="breadcrumb">
    <xsl:param name="list" />
    <xsl:param name="delimiter" select="'/'" />
    <xsl:param name="reminder" select="$list" />
    <xsl:variable name="newlist">
      <xsl:choose>
        <xsl:when test="contains($list, $delimiter)">
          <xsl:value-of select="normalize-space($list)" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(normalize-space($list), $delimiter)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="first" select="substring-before($newlist, $delimiter)" />
    <xsl:variable name="remaining" select="substring-after($newlist, $delimiter)" />
    <xsl:variable name="current" select="substring-before($reminder, $remaining)" />

    <xsl:choose>
      <xsl:when test="$remaining">
        <xsl:choose>
          <xsl:when test="$first = ''">
            <li class="breadcrumb-item home">
              <i class="fas fa-home mr-2"></i>
              <a href="/">Home</a>
            </li>
          </xsl:when>
          <xsl:otherwise>
            <li class="breadcrumb-item">
              <a href="{$current}">
                <xsl:value-of select="$first" />
              </a>
            </li>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:call-template name="breadcrumb">
          <xsl:with-param name="list" select="$remaining" />
          <xsl:with-param name="delimiter" select="$delimiter" />
          <xsl:with-param name="reminder" select="$reminder" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$first = ''">
            <li class="breadcrumb-item home">
              <i class="fas fa-home mr-2"></i>
              <a href="/">Home</a>
            </li>
          </xsl:when>
          <xsl:otherwise>
            <li class="breadcrumb-item active">
              <a href="{$current}">
                <xsl:value-of select="$first" />
              </a>
            </li>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
    <html>
      <head>
        <title>
          <xsl:value-of select="$title" />
        </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="/css/style.css" />
      </head>
      <body class="bg-black text-white p-6">
        <div class="flex justify-between items-center mb-5">
          <ol class="breadcrumb inline">
            <xsl:call-template name="breadcrumb">
              <xsl:with-param name="list" select="$path" />
            </xsl:call-template>
          </ol>
        </div>
        <div class="flex justify-between items-center mb-5">
          <xsl:if test="list/directory">
            <div class="space-x-2">
              <xsl:for-each select="list/directory">
                <div class="inline-block text-yellow-500">
                  <a href="{.}">
                    <i class="fas fa-folder mr-2"></i>
                    <xsl:value-of select="." />
                  </a>
                </div>
              </xsl:for-each>
            </div>
          </xsl:if>
        </div>
        <div class="grid grid-cols-3 gap-2 justify-items-center items-start">
          <xsl:for-each select="list/file">
            <div>
              <xsl:choose>
                <xsl:when test="contains(' mp4 webm mkv avi wmv flv ogv ', concat(' ', substring-after(., '.'), ' '))">
                  <div class="mb-2">
                    <a href="{.}" target="_blank">
                      <xsl:value-of select="." />
                    </a>
                  </div>
                  <div>
                    <video controls="" preload="metadata" class="max-w-full h-auto rounded-lg" src="{.}" title="{.}"/>
                  </div>
                </xsl:when>
                <xsl:otherwise>
                  <div class="mb-2">
                    <a href="{.}" target="_blank">
                      <xsl:value-of select="." />
                    </a>
                  </div>
                  <div>
                    <a href="{.}" target="_blank">
                      <img src="{.}" alt="{.}" title="{.}" loading="lazy" class="inline-block max-w-md max-h-96 align-bottom object-contain rounded-lg"/>
                    </a>
                  </div>
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </xsl:for-each>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
