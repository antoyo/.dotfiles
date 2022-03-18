// Adapted from: https://github.com/johan/stop-chrome-gifanim/blob/master/stop-gif-anim.user.js

// ==UserScript==
// @name           Stop gif animations on escape
// @namespace      http://github.com/johan/
// @description    Implements the "stop gif animations on hitting Ctrl-C" feature that all browsers except Safari and Google Chrome have had since forever. Now also for Google Chrome!
// ==/UserScript==

document.addEventListener('keydown', freeze_gifs_on_escape, true);

function freeze_gifs_on_escape(e) {
    if (e.keyCode == 67 && !e.shiftKey && e.ctrlKey && !e.altKey && !e.metaKey) {
        [].slice.apply(document.images).filter(is_gif_image).map(freeze_gif);
    }
}

function is_gif_image(image) {
    return /^(?!data:).*\.gif/i.test(image.src);
}

function freeze_gif(image) {
    var canvas = document.createElement('canvas');
    var width = canvas.width = image.width;
    var height = canvas.height = image.height;
    var context = canvas.getContext('2d');
    context.drawImage(image, 0, 0);
    context.fill();
    try {
        image.src = canvas.toDataURL("image/gif"); // if possible, retain all css aspects
    }
    catch(e) { // cross-domain -- mimic original with all its tag attributes
        for (var j = 0; j < image.attributes.length; j++) {
            var attribute = image.attributes[j];
            if(attribute.name != "width" && attribute.name != "height") {
                canvas.setAttribute(attribute.name, attribute.value);
            }
        }
        image.parentNode.replaceChild(canvas, image);
    }
}
