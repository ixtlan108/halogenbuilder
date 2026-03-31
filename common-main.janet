
(defn proj-item [[index desc is-first]] 
  (if is-first
    (string/format "\n\n\t%d:\t%s" index desc)
    (string/format "%d:\t%s" index desc)))

(defn proj-help [projs]
  (let [projsx (map proj-item projs)]
    (string/join projsx "\n\t")))
