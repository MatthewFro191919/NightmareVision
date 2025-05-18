import funkin.states.editors.HScriptState;

function customMenu(){ return true; }

function onCreate(){
    FlxG.switchState(new HScriptState('StoryMode'));
}