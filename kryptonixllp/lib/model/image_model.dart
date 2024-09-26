class ImageModel {
    ImageModel({
        required this.id,
        required this.slug,
        required this.alternativeSlugs,
        required this.createdAt,
        required this.updatedAt,
        required this.promotedAt,
        required this.width,
        required this.height,
        required this.color,
        required this.blurHash,
        required this.description,
        required this.altDescription,
        required this.breadcrumbs,
        required this.urls,
        required this.links,
        required this.likes,
        required this.likedByUser,
        required this.currentUserCollections,
        required this.sponsorship,
        required this.topicSubmissions,
        required this.assetType,
        required this.user,
    });

    final String? id;
    final String? slug;
    final AlternativeSlugs? alternativeSlugs;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final DateTime? promotedAt;
    final int? width;
    final int? height;
    final String? color;
    final String? blurHash;
    final String? description;
    final String? altDescription;
    final List<dynamic> breadcrumbs;
    final Urls? urls;
    final ImageModelLinks? links;
    final int? likes;
    final bool? likedByUser;
    final List<dynamic> currentUserCollections;
    final Sponsorship? sponsorship;
    final TopicSubmissions? topicSubmissions;
    final String? assetType;
    final User? user;

    factory ImageModel.fromJson(Map<String, dynamic> json){ 
        return ImageModel(
            id: json["id"],
            slug: json["slug"],
            alternativeSlugs: json["alternative_slugs"] == null ? null : AlternativeSlugs.fromJson(json["alternative_slugs"]),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            promotedAt: DateTime.tryParse(json["promoted_at"] ?? ""),
            width: json["width"],
            height: json["height"],
            color: json["color"],
            blurHash: json["blur_hash"],
            description: json["description"],
            altDescription: json["alt_description"],
            breadcrumbs: json["breadcrumbs"] == null ? [] : List<dynamic>.from(json["breadcrumbs"]!.map((x) => x)),
            urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
            links: json["links"] == null ? null : ImageModelLinks.fromJson(json["links"]),
            likes: json["likes"],
            likedByUser: json["liked_by_user"],
            currentUserCollections: json["current_user_collections"] == null ? [] : List<dynamic>.from(json["current_user_collections"]!.map((x) => x)),
            sponsorship: json["sponsorship"] == null ? null : Sponsorship.fromJson(json["sponsorship"]),
            topicSubmissions: json["topic_submissions"] == null ? null : TopicSubmissions.fromJson(json["topic_submissions"]),
            assetType: json["asset_type"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

}

class AlternativeSlugs {
    AlternativeSlugs({
        required this.en,
        required this.es,
        required this.ja,
        required this.fr,
        required this.it,
        required this.ko,
        required this.de,
        required this.pt,
    });

    final String? en;
    final String? es;
    final String? ja;
    final String? fr;
    final String? it;
    final String? ko;
    final String? de;
    final String? pt;

    factory AlternativeSlugs.fromJson(Map<String, dynamic> json){ 
        return AlternativeSlugs(
            en: json["en"],
            es: json["es"],
            ja: json["ja"],
            fr: json["fr"],
            it: json["it"],
            ko: json["ko"],
            de: json["de"],
            pt: json["pt"],
        );
    }

}

class ImageModelLinks {
    ImageModelLinks({
        required this.self,
        required this.html,
        required this.download,
        required this.downloadLocation,
    });

    final String? self;
    final String? html;
    final String? download;
    final String? downloadLocation;

    factory ImageModelLinks.fromJson(Map<String, dynamic> json){ 
        return ImageModelLinks(
            self: json["self"],
            html: json["html"],
            download: json["download"],
            downloadLocation: json["download_location"],
        );
    }

}

class Sponsorship {
    Sponsorship({
        required this.impressionUrls,
        required this.tagline,
        required this.taglineUrl,
        required this.sponsor,
    });

    final List<String> impressionUrls;
    final String? tagline;
    final String? taglineUrl;
    final User? sponsor;

    factory Sponsorship.fromJson(Map<String, dynamic> json){ 
        return Sponsorship(
            impressionUrls: json["impression_urls"] == null ? [] : List<String>.from(json["impression_urls"]!.map((x) => x)),
            tagline: json["tagline"],
            taglineUrl: json["tagline_url"],
            sponsor: json["sponsor"] == null ? null : User.fromJson(json["sponsor"]),
        );
    }

}

class User {
    User({
        required this.id,
        required this.updatedAt,
        required this.username,
        required this.name,
        required this.firstName,
        required this.lastName,
        required this.twitterUsername,
        required this.portfolioUrl,
        required this.bio,
        required this.location,
        required this.links,
        required this.profileImage,
        required this.instagramUsername,
        required this.totalCollections,
        required this.totalLikes,
        required this.totalPhotos,
        required this.totalPromotedPhotos,
        required this.totalIllustrations,
        required this.totalPromotedIllustrations,
        required this.acceptedTos,
        required this.forHire,
        required this.social,
    });

    final String? id;
    final DateTime? updatedAt;
    final String? username;
    final String? name;
    final String? firstName;
    final String? lastName;
    final String? twitterUsername;
    final String? portfolioUrl;
    final String? bio;
    final String? location;
    final UserLinks? links;
    final ProfileImage? profileImage;
    final String? instagramUsername;
    final int? totalCollections;
    final int? totalLikes;
    final int? totalPhotos;
    final int? totalPromotedPhotos;
    final int? totalIllustrations;
    final int? totalPromotedIllustrations;
    final bool? acceptedTos;
    final bool? forHire;
    final Social? social;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            username: json["username"],
            name: json["name"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            twitterUsername: json["twitter_username"],
            portfolioUrl: json["portfolio_url"],
            bio: json["bio"],
            location: json["location"],
            links: json["links"] == null ? null : UserLinks.fromJson(json["links"]),
            profileImage: json["profile_image"] == null ? null : ProfileImage.fromJson(json["profile_image"]),
            instagramUsername: json["instagram_username"],
            totalCollections: json["total_collections"],
            totalLikes: json["total_likes"],
            totalPhotos: json["total_photos"],
            totalPromotedPhotos: json["total_promoted_photos"],
            totalIllustrations: json["total_illustrations"],
            totalPromotedIllustrations: json["total_promoted_illustrations"],
            acceptedTos: json["accepted_tos"],
            forHire: json["for_hire"],
            social: json["social"] == null ? null : Social.fromJson(json["social"]),
        );
    }

}

class UserLinks {
    UserLinks({
        required this.self,
        required this.html,
        required this.photos,
        required this.likes,
        required this.portfolio,
        required this.following,
        required this.followers,
    });

    final String? self;
    final String? html;
    final String? photos;
    final String? likes;
    final String? portfolio;
    final String? following;
    final String? followers;

    factory UserLinks.fromJson(Map<String, dynamic> json){ 
        return UserLinks(
            self: json["self"],
            html: json["html"],
            photos: json["photos"],
            likes: json["likes"],
            portfolio: json["portfolio"],
            following: json["following"],
            followers: json["followers"],
        );
    }

}

class ProfileImage {
    ProfileImage({
        required this.small,
        required this.medium,
        required this.large,
    });

    final String? small;
    final String? medium;
    final String? large;

    factory ProfileImage.fromJson(Map<String, dynamic> json){ 
        return ProfileImage(
            small: json["small"],
            medium: json["medium"],
            large: json["large"],
        );
    }

}

class Social {
    Social({
        required this.instagramUsername,
        required this.portfolioUrl,
        required this.twitterUsername,
        required this.paypalEmail,
    });

    final String? instagramUsername;
    final String? portfolioUrl;
    final String? twitterUsername;
    final dynamic paypalEmail;

    factory Social.fromJson(Map<String, dynamic> json){ 
        return Social(
            instagramUsername: json["instagram_username"],
            portfolioUrl: json["portfolio_url"],
            twitterUsername: json["twitter_username"],
            paypalEmail: json["paypal_email"],
        );
    }

}

class TopicSubmissions {
    TopicSubmissions({
        required this.travel,
    });

    final Travel? travel;

    factory TopicSubmissions.fromJson(Map<String, dynamic> json){ 
        return TopicSubmissions(
            travel: json["travel"] == null ? null : Travel.fromJson(json["travel"]),
        );
    }

}

class Travel {
    Travel({
        required this.status,
        required this.approvedOn,
    });

    final String? status;
    final DateTime? approvedOn;

    factory Travel.fromJson(Map<String, dynamic> json){ 
        return Travel(
            status: json["status"],
            approvedOn: DateTime.tryParse(json["approved_on"] ?? ""),
        );
    }

}

class Urls {
    Urls({
        required this.raw,
        required this.full,
        required this.regular,
        required this.small,
        required this.thumb,
        required this.smallS3,
    });

    final String? raw;
    final String? full;
    final String? regular;
    final String? small;
    final String? thumb;
    final String? smallS3;

    factory Urls.fromJson(Map<String, dynamic> json){ 
        return Urls(
            raw: json["raw"],
            full: json["full"],
            regular: json["regular"],
            small: json["small"],
            thumb: json["thumb"],
            smallS3: json["small_s3"],
        );
    }

}
