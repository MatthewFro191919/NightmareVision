function setupNote(note){
    note.reloadNote('notes/epic-');
    note.colorSwap.hue = 0;
    note.colorSwap.saturation = 0;
    note.colorSwap.brightness = 0;
    note.canMiss = true;
    note.hitCausesMiss = false;
    note.noAnimation = true;
}