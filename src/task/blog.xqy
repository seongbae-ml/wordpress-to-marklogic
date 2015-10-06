xquery version "1.0-ml";

import module namespace rss = "http://marklogic.com/rss" at "/task/feed-lib.xqy";

let $siteurl := "marklogicprod:8888"

let $contentTypes := ("ml_solution","ml_customer")

for $contentType in $contentTypes
return rss:load-page($siteurl, $contentType, 1, ($siteurl, $siteurl || "/" || $contentType))

