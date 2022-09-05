function removeAds() {
    let posts = document.querySelectorAll("[aria-describedby]");
    for(post of posts) {
        let lines = post.innerText.split("\n");
        for(let i = 0 ; i < 10 ; i++) {
            let line = lines[i];
            if(line && (line.startsWith("Commandité") || line.startsWith("Suggestion pour vous"))) {
                // We just hide it instead of not displaying it because the latter will make Facebook scroll back up.
                post.style.visibility = "hidden";
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
