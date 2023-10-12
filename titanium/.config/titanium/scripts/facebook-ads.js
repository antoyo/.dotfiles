function removeAds() {
    let posts = document.querySelectorAll("[aria-describedby]");
    for(post of posts) {
        let lines = post.innerText.split("\n");
        for(let i = 0 ; i < 10 ; i++) {
            let line = lines[i];
            if(line && (line.startsWith("Commandité") || line.startsWith("Suggestion") || line.startsWith("Reels") || line.startsWith("Stories"))) {
                // We just hide it instead of not displaying it because the latter will make Facebook scroll back up.
                post.style.visibility = "hidden";
            }
        }

        // Facebook also hide text in referenced SVG elements. Clever boy.
        let svgs = post.querySelectorAll("[aria-describedby] svg");
        for(svg of svgs) {
            let textId = svg.children[0].getAttribute("xlink:href");
            if (textId != null) {
                let textNode = document.querySelector(textId);
                if(textNode.innerHTML == "Commandité") {
                    // We just hide it instead of not displaying it because the latter will make Facebook scroll back up.
                    post.style.visibility = "hidden";
                }
            }
        }
    }
}

(function() {
    window.addEventListener('scroll', () => {
        removeAds();
        setTimeout(removeAds, 1000);
    });
})();
