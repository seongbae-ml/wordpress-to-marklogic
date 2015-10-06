xquery version "1.0-ml";

module namespace rss = "http://marklogic.com/rss";

declare function rss:load-page($siteurl, $feed, $page-num, $additionalcollections) {
  let $log := xdmp:log("loading page " || $page-num)
  let $url :=
   'http://' || $siteurl || '/feed/?post_type=' || $feed ||
      (if ($page-num gt 1) then
       '&amp;paged=' || $page-num
       else
         ())

  let $log := xdmp:log("url= " || $url)

  

  let $response :=
    xdmp:http-get(
      $url,
      <options xmlns="xdmp:document-get">
        <repair>full</repair>
      </options>)

  
  let $items := $response[2]/rss/channel/item

  let $pubDate := $response[2]/rss/channel/item/pubDate


  let $insert :=
    $items ! xdmp:document-insert(
      ./link/fn:replace(.,"/$","") || ".xml",
      .,
      xdmp:default-permissions(),
      $additionalcollections
    )

  return
    if (fn:count($items) gt 0) then
      rss:load-page($siteurl, $feed, $page-num + 1, $additionalcollections)
    else (
      
    )

};
