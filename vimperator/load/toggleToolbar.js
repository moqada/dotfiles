/**
 * toggleToolbar
 *
 * @author halt feits <halt.feits@gmail.com>
 * @version 0.6.0
 */

(function() {

liberator.modules.commands.addUserCommand(["toggleToolbar"], 'toggleToolbar',
    function ()
    {
      var guioptions = liberator.modules.options.get('guioptions');

      if (guioptions.value == 'Tmnrb') {
        guioptions.value = liberator.modules.options.getPref('guioptions');

        var toolbar = document.getElementById("webdeveloper-toolbar");
        if (toolbar) {
            //toolbar.collapsed = false;
            toolbar.collapsed = true;
            //document.persist("webdeveloper-toolbar", "collapsed");
        }

      } else {
        liberator.modules.options.setPref('guioptions', guioptions.value);
        guioptions.value = 'Tmnrb';

        var toolbar = document.getElementById("webdeveloper-toolbar");
        if (toolbar) {
            //toolbar.collapsed = true;
            toolbar.collapsed = false;
            //document.persist("webdeveloper-toolbar", "collapsed");
        }

      }

      guioptions.setter(guioptions.value);
    },
    {
        shortHelp:'toggle toolbar'
    }
);

liberator.execute('toggleToolbar');
})();

