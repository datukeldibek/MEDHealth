//
//  SocialMediaLinksViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import SafariServices

final class SocialMediaLinksViewModel {
    private var socialMediaLinks: [URL]
    private let helper = SafariOpener.shared
    
    init() {
        socialMediaLinks = [
            .init(string: "https://www.facebook.com/Medcheck.kg/")!,
            .init(string: "https://www.instagram.com/medcheck.kg/")!
        ]
    }
    
    public func openFacebookPage() {
        helper.openSafari(with: socialMediaLinks[0])
    }
    
    public func openInstagramPage() {
        helper.openSafari(with: socialMediaLinks[1])
    }
}
