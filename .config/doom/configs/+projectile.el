(after! projectile
  (add-to-list 'projectile-globally-ignored-directories "node_modules")
  (add-to-list 'projectile-globally-ignored-directories "out")
  (add-to-list 'projectile-globally-ignored-directories "dist-newstyle")
  (add-to-list 'projectile-globally-ignored-directories "_build")
  (add-to-list 'projectile-globally-ignored-directories ".metals")
  (add-to-list 'projectile-globally-ignored-directories "target"))
