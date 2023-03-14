//
//  Track.swift
//  Flixster
//
//  Created by CHENGTAO on 3/5/23.
//

import Foundation

//struct Rating {
//    let averageUserRating: Float
//    let totalVote: Int
//}

struct MovieTrackResponse: Decodable {
    let results: [MovieTrack]
}

struct MovieTrack: Decodable {
    let original_title: String
    let title: String
    let overview: String
    let release_date: String
    let poster_path: URL
    let backdrop_path: URL
    let vote_count: Int
    let vote_average: Float
    let popularity: Float
}

//struct MovieTrack {
//    let trackName: String
//    let artistName: String
//    let artworkUrl100: URL
//    let previewUrl: URL
//    let trackPrice: Float
//    let releaseDate: Date
//    let trackTimeMillis: Int
//    let rating: Rating
//    let shortDescription: String
//    let longDescription: String
//    let primaryGenreName: String
//}

//extension MovieTrack {
//    // An array of movie tracks
//    static var movieInfo: [MovieTrack] = [
//        MovieTrack(trackName: "Star Wars: The Phantom Menace",
//                   artistName: "George Lucas",
//                   artworkUrl100: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Video123/v4/18/98/ce/1898cea4-56a5-0542-c115-f1057ed45fea/pr_source.lsr/100x100bb.jpg")!,
//                   previewUrl: URL(string: "https://video-ssl.itunes.apple.com/itunes-assets/Video113/v4/4c/88/67/4c8867ee-f781-cc02-fd72-972a1d11ac7e/mzvf_4694524656895114499.640x360.h264lc.U.p.m4v")!,
//                   trackPrice: 9.99,
//                   releaseDate: formattedReleaseDate(dateString: "1999-05-19T07:00:00Z")!,
//                   trackTimeMillis: 8180628,
//                   rating:Rating(averageUserRating: 3.6, totalVote: 827),
//                   shortDescription: "For the first time ever on digital, experience the heroic action and unforgettable adventures of",
//                   longDescription: "Experience the heroic action and unforgettable adventures of Star Wars: Episode I - The Phantom Menace.  See the first fateful steps in the journey of Anakin Skywalker. Stranded on the desert planet Tatooine after rescuing young Queen Amidala from the impending invasion of Naboo, Jedi apprentice Obi-Wan Kenobi and his Jedi Master Qui-Gon Jinn discover nine-year-old Anakin, a young slave unusually strong in the Force. Anakin wins a thrilling Podrace and with it his freedom as he leaves his home to be trained as a Jedi. The heroes return to Naboo where Anakin and the Queen face massive invasion forces while the two Jedi contend with a deadly foe named Darth Maul. Only then do they realize the invasion is merely the first step in a sinister scheme by the re-emergent forces of darkness known as the Sith.",
//                   primaryGenreName: "Action & Adventure"),
//
//        MovieTrack(trackName: "Fortune Favors Lady Nikuko",
//                   artistName: "Ayumu Watanabe",
//                   artworkUrl100: URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Video122/v4/77/bd/18/77bd1846-f3a9-8a06-8a8d-f85120cb2825/Fortune_Favors_Lady_Nikuko_2000x3000_V2.png/100x100bb.jpg")!,
//                   previewUrl: URL(string: "https://video-ssl.itunes.apple.com/itunes-assets/Video112/v4/7b/aa/6d/7baa6dce-0e12-95ca-2594-c84bde3baf04/mzvf_10015320760578554371.640x360.h264lc.U.p.m4v")!,
//                   trackPrice: 8.99,
//                   releaseDate: formattedReleaseDate(dateString: "2022-07-19T07:00:00Z")!,
//                   trackTimeMillis: 5779263,
//                   rating: Rating(averageUserRating: 5.0, totalVote: 1),
//                   shortDescription: "Brash single-mother Nikuko is well-known for her bold spirit, much to the embarrassment of Kikuko",
//                   longDescription: "Brash single-mother Nikuko is well-known for her bold spirit, much to the embarrassment of Kikuko, her pensive daughter. But when a shocking revelation from the past threatens the pair’s relationship, they must consider the true meaning of family.",
//                   primaryGenreName: "Anime"),
//
//        MovieTrack(trackName: "A Man Called Otto",
//                   artistName: "Marc Forster",
//                   artworkUrl100: URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Video116/v4/cb/de/25/cbde2553-053a-c2c1-b4ec-4c5993609293/SPE_MAN_CALLED_OTTO_A_TH_ITUNES_US_ARTWORK_EN-US_2000x3000_3MNEN100000BQW.lsr/100x100bb.jpg")!,
//                   previewUrl: URL(string: "https://video-ssl.itunes.apple.com/itunes-assets/Video123/v4/3a/b0/93/3ab093fc-3e29-f38c-87f4-fd89002bfb00/mzvf_9128221600680329777.640x460.h264lc.U.p.m4v")!,
//                   trackPrice: 14.99,
//                   releaseDate: formattedReleaseDate(dateString: "2023-01-13T08:00:00Z")!,
//                   trackTimeMillis: 7568895,
//                   rating: Rating(averageUserRating: 4.3, totalVote: 31),
//                   shortDescription: "Based on the comical and moving # 1 New York Times bestseller, A Man Called Otto tells the story of",
//                   longDescription: "Based on the # 1 New York Times bestseller “A Man Called Ove,” A Man Called Otto tells the story of Otto Anderson (Tom Hanks), a grump who no longer sees purpose in his life following the loss of his wife. Otto is ready to end it all, but his plans are interrupted when a lively young family moves in next door, and he meets his match in quick-witted Marisol. She challenges him to see life differently, leading to an unlikely friendship that turns his world around. A heartwarming and funny story about love, loss, and life, A Man Called Otto shows that family can sometimes be found in the most unexpected places.",
//                   primaryGenreName: "Drama"),
//
//        MovieTrack(trackName: "Frozen",
//                   artistName: "Chris Buck & Jennifer Lee",
//                   artworkUrl100: URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Video113/v4/2c/75/fc/2c75fc0a-b2d9-1d15-8e4d-1022a98b261f/pr_source.lsr/100x100bb.jpg")!,
//                   previewUrl: URL(string: "https://video-ssl.itunes.apple.com/itunes-assets/Video122/v4/09/07/3f/09073ffd-684d-bf8c-7c5b-f3ff092c2637/mzvf_1634601757057628202.640x378.h264lc.U.p.m4v")!,
//                   trackPrice: 19.99,
//                   releaseDate: formattedReleaseDate(dateString: "2013-11-27T08:00:00Z")!,
//                   trackTimeMillis: 6165283,
//                   rating: Rating(averageUserRating: 4.4, totalVote: 17800),
//                   shortDescription: "In \"Frozen,\" fearless optimist Anna teams up with rugged mountain man Kristoff and his loyal",
//                   longDescription: "In “Frozen,” fearless optimist Anna teams up with rugged mountain man Kristoff and his loyal reindeer Sven in an epic journey, encountering Everest-like conditions, mystical trolls and a hilarious snowman named Olaf in a race to find Anna's sister Elsa, whose icy powers have trapped the kingdom of Arendelle in eternal winter.",
//                   primaryGenreName: "Kids & Family"),
//
//        MovieTrack(trackName: "Pitch Perfect",
//                   artistName: "Jason Moore",
//                   artworkUrl100: URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Video49/v4/99/97/7c/99977caa-462e-6031-5bf9-3c6188a38b70/pr_source.lsr/100x100bb.jpg")!,
//                   previewUrl: URL(string: "https://video-ssl.itunes.apple.com/itunes-assets/Video127/v4/1c/3b/d6/1c3bd68a-dab8-3928-72b1-95800868cbe0/mzvf_7226168872147311352.640x458.h264lc.U.p.m4v")!,
//                   trackPrice: 19.99,
//                   releaseDate: formattedReleaseDate(dateString: "2012-09-28T07:00:00Z")!,
//                   trackTimeMillis: 6720895,
//                   rating: Rating(averageUserRating: 4.5, totalVote: 9200),
//                   shortDescription: "Arriving at her new college, Beca (Anna Kendrick) finds herself not right for any clique but somehow is muscled",
//                   longDescription: "Arriving at her new college, Beca (Anna Kendrick) finds herself not right for any clique but somehow is muscled into one that she never would have picked on her own: alongside mean girls, sweet girls and weird girls whose only thing in common is how good they sound when they sing together. When Beca leads this a cappella singing group out of their traditional arrangements and perfect harmonies into all-new mash-ups, they fight to climb their way to the top of college music competitions.",
//                   primaryGenreName: "Comedy")
//    ]
//}



// MARK: Helper Methods
/// Converts milliseconds to hh:mm:ss format
func formattedTrackDuration(with milliseconds: Int) -> String {
    let (minutes, seconds) = milliseconds.quotientAndRemainder(dividingBy: 60 * 1000)
    let hours = minutes / 60
    let truncatedMinutes = minutes % 60
    let truncatedSeconds = seconds / 1000
    if hours >= 10 {
        return "\(hours):\(truncatedMinutes):\(truncatedSeconds)"
    } else if truncatedMinutes >= 10 {
        return "\(hours):\(truncatedMinutes):\(truncatedSeconds)"
    } else {
        return "\(hours):0\(truncatedMinutes):\(truncatedSeconds)"
    }
}

/// Converts date from String type to Date format
func formattedReleaseDate(dateString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: dateString)
}

/// Converts number of people  from Int type to  String
/// ex: 9200 -> 9.2k
func formatNumber(_ number: Int) -> String {
    let thousand = 1000
    let million = thousand * 1000
    let billion = million * 1000
    let trillion = billion * 1000

    switch number {
    case 0..<thousand:
        return "\(number)"
    case thousand..<million:
        let value = Double(number) / Double(thousand)
        return String(format: "%.1fK", value)
    case million..<billion:
        let value = Double(number) / Double(million)
        return String(format: "%.1fM", value)
    case billion..<trillion:
        let value = Double(number) / Double(billion)
        return String(format: "%.1fB", value)
    default:
        let value = Double(number) / Double(trillion)
        return String(format: "%.1fT", value)
    }
}

/// Return a Image URL from TMDB with possible size.
/// ex: https://image.tmdb.org/t/p/{size}/{poster_path}
func ImageRequestURL(poster: URL, size: String) -> URL {
    URL(string: "https://image.tmdb.org/t/p/\(size)/\(poster.absoluteString)")!
}

