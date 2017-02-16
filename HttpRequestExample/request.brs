function cachedContent()
  ? "main -> cachedContent->"
    content_url = "http://www.khanacademy.org/api/v1/playlists"
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    ' request.EnableEncodings(true)
    request.SetMessagePort(port)

    request.SetURL(content_url)
    if (request.AsyncGetToString())
      while (true)
        msg = wait(0, port)
        if (type(msg) = "roUrlEvent")
          code = msg.GetResponseCode()
          ? "XXXXXXXXXcode" code
          if (code = 200)
            playlist = CreateObject("roArray", 10, true)
            json = ParseJSON(msg.GetString())
            for each kind in json
              topic = {
                ID: kind.id
                Title: kind.standalone_title
              }
              playlist.push(topic)
            end for
            ? "CCCCCCCCCC" playlist[0].id "========" playlist[0].Title
            return playlist
          end if
        end if
      end while
    end if
  return json
end function
