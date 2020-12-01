//
//  Constants.swift
//  youtube-onedaybuild
//
//  Created by Anh Dinh on 11/24/20.
//

import Foundation

struct Constants {
    
    static var API_KEY = "AIzaSyD61KeCiwOray8Hz13ZaGmW-upbka48St0"
    static var PLAYLIST_ID = "UU2D6eRvCeMtcF5OGHf1-trw&index=1"
    static var API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
    static var VIDEOCELL_ID = "VideoCell"
}
