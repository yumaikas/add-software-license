(def template ```Copyright (c) ##YEAR## ##NAME## 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.```)

(def fullname-pat ~{
    :main (* "Full Name" :s+ (capture (some (if-not "\n" 1))))
})

(defn get-user-full-name-windows [] 
    (def cmd (string "net user " (os/getenv "USERNAME")))
    (var retval nil)
    (with [f (file/popen cmd)]
        (while (def l (:read f :line))
            (when (def m (peg/match fullname-pat l))
                (set retval (m 0))
                (break)
            )
        )
    )
    retval
)

(defn main [&] 
    (def year (string ((os/date (os/time) :local) :year))) 
    (def author (or (os/getenv "AUTHOR" (get-user-full-name-windows))))
    (as-> (string/replace "##YEAR##" year template) it
        (string/replace "##NAME##" "Andrew Owen" it)
        (spit "LICENSE.md" it)
    )
)
