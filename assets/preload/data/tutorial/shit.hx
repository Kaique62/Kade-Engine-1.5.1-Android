package assets.preload.data.tutorial;

function onCreate()
    {
        if (PlayState.leakSatan != null)
        {
            PlayState.leakSatan.animation.callback = function(n, f, i)
            {
                if (n == "idle")
                {
                    PlayState.leakSatan.visible = false;
                }
                else
                {
                    PlayState.leakSatan.visible = true;
                }
            }
        }
    }