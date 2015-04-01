(when (and (eq system-type 'darwin) (string= "/" default-directory))
  (cd "~/src")
  )
