;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Homework 9|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Homework 9 Chia Hao Hsu Tai, Mahiro Yamakawa

; Constants : 

(require 2htdp/image)
(require 2htdp/universe)
(define SIZE 800)
(define HALF (/ SIZE 2))
(define FROG-TOP (overlay (circle (/ SIZE 200)  "solid" "black")
                          (circle (/ SIZE 100) "solid" "red")))
(define FROG-BOTTOM2 (overlay (circle (/ SIZE 200) "solid" "black")
                              (circle (/ SIZE 100) "solid" "red")))
(define FROG-BOTTOM (place-image FROG-BOTTOM2 12 15 (circle (/ SIZE 40) "solid" "green")))
(define FROG (place-image FROG-TOP 28 15 FROG-BOTTOM))
(define FROG-L (rotate 90 FROG))
(define FROG-D (rotate 180 FROG))
(define FROG-R (rotate 270 FROG))
(define VEHICLE-SMALL (rectangle (/ SIZE 10) (/ SIZE 20) "solid" "red"))
(define ROAD (rectangle SIZE (/ SIZE 4) "solid" "black"))
(define WATER (rectangle SIZE (/ SIZE 4) "solid" "sky blue"))
(define SH (rectangle SIZE (/ SIZE 20) "solid" "dark green"))
(define SCENE (above SH (above WATER (above SH (above ROAD SH)))))
(define WOOD-IMAGE (rectangle (/ SIZE 10) (/ SIZE 20) "solid" "brown"))
(define TURTLE-IMAGE (rectangle (/ SIZE 10) (/ SIZE 20) "solid" "light green"))

; Data Definitions : 

;; A ListofNumber is on of:
;; -empty
;; -(cons Number ListofNumber)
;; Represents a list of number)

(define list0 '())
(define list1 (cons 5 list0))
(define list2 (cons 3 list1))
(define list3 (cons 1 list2))
; list-templ : [List-of Number] -> ...
#;(define (list-templ al)
    (cond
      [(empty? al) ...]
      [(cons? al) ... (first al)
                  ...(list-templ (rest al))...]))

; A Direction is one of: "left" "right"

(define d-left "left")
(define d-right "right")
; dire-templ : Direction -> ...
#; (define (dire-temple ad)
     ...(string=? "left" ad)...
     ...(string=? "right" ad)...)

; A Face is one of: "left" "right" "up" "down"

(define f-l "left")
(define f-r "right")
(define f-u "up")
(define f-d "down")
; face-templ : face -> ...
#; (define (face-templ af)
     ...(string=? af "left")...
     ...(string=? af "right")...
     ...(string=? af "up")...
     ...(string=? af "down")...)

; A Player is a (make-player Number Number)
(define-struct player (x y face))
; The two points represents the location of the player on the SCENE

(define player-init   (make-player (/ SIZE 2) 500 "up"))
(define player-random (make-player (/ SIZE 4) 100 "left"))
(define player-win    (make-player 100 40 "down"))
; player-templ : Player -> ...
#; (define (player-templ ap)
     ...(player-x ap) ...
     ...(player-y ap) ...
     ...(face-templ (player-face ap))...)
 
; A Vehicle is a (make-vehicle Number Number Direction)
(define-struct vehicle (x y dir))
; x and y represents the loction on SCENE
; dir represts the direction the vehicle moves

(define veh-1-1 (make-vehicle 0 380 "left"))
(define veh-1-2 (make-vehicle 200 380 "left"))
; veh-templ : Vehicle -> ...
#; (define (veh-templ av)
     ...(vehicle-x av)...
     ...(vehicle-y av)...
     ...(dire-temple (vehicle-dir av)...))

; A Set of Vehicles (VSet) is one of:     
; - empty     
; - (cons Vehicle VSet)

(define vset-0 '())
(define vset-1 (cons veh-1-1 '()))
(define vset-2 (cons veh-1-2 vset-1))
(define vset-3 (cons veh-1-2 '()))
; vset-templ : VSet -> ...
#; (define (vset-temple avset)
     (cond
       [(empty? avset) ...]
       [(cons? avset) ...(veh-templ (first avset))...
                      ...(vset-templ (rest avset))...]))


(define-struct wood (x y dir))
; A Wood is (make-wood Number Number Direction)
; A Wood is a object on the river where place can land safely, only move right

(define wood-1 (make-wood 0 180 "right"))
(define wood-2 (make-wood 200 180 "right"))
; wood-templ : Wood -> ...
#; (define (wood-templ aw)
     ...(wood-x aw) ...
     ...(wood-y aw) ...
     ...(wood-dir aw) ...)

; A Set of Wood(WSet) is one of
; - '()
; - (cons Wood WSet)

(define wset-0 '())
(define wset-1 (cons wood-1 '()))
(define wset-2 (cons wood-2 wset-1))
(define wset-3 (cons wood-2 '()))
; wset-templ : WSet -> ...
#; (define (wset-templ awset)
     (cond
       [(empty? awset) ...]
       [(cons? awset) ...(wood-templ (first awset))...
                      ...(wset-templ (rest awset))...]))

(define-struct turtle (x y dir))
; A Turtle is (make-wood Number Number Direction)
; A Turlte is a object that on the river where place can land safely, it moves left only

(define turtle-1 (make-turtle 0 180 "left"))
(define turtle-2 (make-turtle 200 180 "left"))
; turtle-templ : Turtle -> ...
#; (define (turtle-templ aw)
     ...(turtle-x aw) ...
     ...(turtle-y aw) ...
     ...(turtle-dir aw) ...)

; A Set of Turtle(TSet) is one of
; - '()
; - (cons Turtle TSet)

(define tset-0 '())
(define tset-1 (cons turtle-1 '()))
(define tset-2 (cons turtle-2 tset-1))
(define tset-3 (cons turtle-2 '()))
; tset-templ : TSet -> ...
#; (define (tset-templ atset)
     (cond
       [(empty? atset) ...]
       [(cons? atset)  ...(turtle-templ (first atset))...
                       ...(tset-templ (rest atset))...]))

(define-struct world (player vehicles woods turtles))
; A World is a (make-world Player VSet WSet)
; The VSet represents the set of vehicles moving across the screen
; The WSet represents the set of brown planks moving across the screen from right to left
; The TSet represents the set of green turtles moving across the screen from left to right

(define  world-check  (make-world player-init vset-1 wset-1 tset-1))
(define world-check2  (make-world player-init vset-3 wset-3 tset-3))
(define world-check3  (make-world player-init
                                  (list (make-vehicle 100 340 "right"))
                                  (list (make-wood    100 140 "right"))
                                  (list (make-turtle  100 240 "left"))))
(define world-check4  (make-world player-init
                                  (list (make-vehicle 800 340 "right"))
                                  (list (make-wood    800 140 "right"))
                                  (list (make-turtle  100 240 "left"))))
(define world-check5  (make-world player-init
                                  (list (make-vehicle 800 340 "right"))
                                  (list (make-wood      0 140 "right"))
                                  (list (make-turtle  100 240 "left"))))
(define    world-lost (make-world (make-player 0 180 "up") vset-1 wset-1 tset-1))
(define world-check-w (make-world (make-player 0 180 "up") vset-1 wset-1 tset-1))
(define world-check3w (make-world (make-player 100 140 "up")
                                  (list (make-vehicle 100 340 "right"))
                                  (list (make-wood    100 140 "right"))
                                  (list (make-turtle  100 240 "left"))))
(define world-check6  (make-world (make-player (/ SIZE 2) 500 "down") vset-3 wset-3 tset-3))
(define world-check7  (make-world (make-player (/ SIZE 2) 500 "right") vset-3 wset-3 tset-3))
(define world-check8  (make-world (make-player (/ SIZE 2) 500 "left") vset-3 wset-3 tset-3))
(define    world-win  (make-world player-win vset-1 wset-1 tset-1))
; world-templ : World -> ...
#;(define (world-templ aw)
    ...(player-templ (world-player aw))...
    ...(vset-templ (world-vehicles aw))...
    ...(wset-templ (world-woods aw))...)

; list-make : Number Number Number String String -> V-Set
; takes number of car, y-cordinate of the car, x-cordinate of the first car in the list,
; direction of the car, and a "v" or "w"
; where "v" makes a VSet
; where "w" makes a WSet
(check-expect (list-make 4 0 380 "left" "v")
              (list (make-vehicle 0 380 "left") (make-vehicle 200 380 "left")
                    (make-vehicle 400 380 "left") (make-vehicle 600 380 "left")))
(check-expect (list-make 1 0 400 "right" "w")
              (list (make-wood 0 400 "right")))

(define (list-make car-n x y dir v/w/t)
  (local
    [;maker : Number -> Vehicle or Wood or Turtle
     ;makes Vehicle from number
     ;x=0 y=380 dir="left" v/w=v (check-expect (maker 3) (make-vehicle 600 380 "left"))
     ;x=0 y=380 dir="left" v/w=w (check-expect (maker 1) (make-wood 200 380 "left"))
     (define (maker n)
       (cond
         [(string=? "v" v/w/t) (make-vehicle (* n 200) y dir)]
         [(string=? "w" v/w/t) (make-wood    (* n 200) y dir)]
         [(string=? "t" v/w/t) (make-turtle  (* n 200) y dir)]))]
    (build-list car-n maker)))

; Constants for the moving objects

(define v-set-lane1 (list-make 4   0 460  "left" "v"))
(define v-set-lane2 (list-make 4 100 420 "right" "v"))
(define v-set-lane3 (list-make 4   0 380  "left" "v"))
(define v-set-lane4 (list-make 4 100 340 "right" "v"))
(define v-set-lane5 (list-make 4   0 300 "left"  "v"))
(define vset-all (append v-set-lane1 v-set-lane2 v-set-lane3 v-set-lane4 v-set-lane5))

(define w-set-lane1 (list-make 4   0 180 "right" "w"))
(define w-set-lane3 (list-make 4   0 100 "right" "w"))
(define wset-all (append w-set-lane1 w-set-lane3))

(define t-set-lane0 (list-make 4 100 220  "left" "t"))
(define t-set-lane2 (list-make 4 100 140  "left" "t"))
(define t-set-lane4 (list-make 4 100  60  "left" "t"))
(define tset-all (append t-set-lane0 t-set-lane2 t-set-lane4))

(define world-init (make-world player-init vset-all wset-all tset-all)) ; ---- to run ----

; to run the game type the following in the command window: (main world-init)

; Main Function/Code : -------------------------------------------------

;;main: World -> World
;; plays the frog game
(define (main initial-w)
  (local [(define get-p-y  (λ (i) (player-y (world-player i))))
          (define last-pic (λ (i) (if (<= (get-p-y i) 20)
                                      (text "YOU WON !!!" 35 "olive")
                                      (text "too bad you died" 35 "olive"))))]
    (big-bang initial-w
      [to-draw draw-world]
      [on-tick move-world]
      [on-key move-player]
      [stop-when done? last-pic])))

;; draw-world: World -> Image
;; takes in the world and draws it out
(check-expect (draw-world world-check)
              (place-image TURTLE-IMAGE 0 180
                           (place-image WOOD-IMAGE 0 180
                                        (place-image VEHICLE-SMALL 0 380
                                                     (place-image FROG (/ SIZE 2) 500 SCENE)))))
(check-expect (draw-world world-check2)
              (place-image TURTLE-IMAGE 200 180
                           (place-image WOOD-IMAGE 200 180
                                        (place-image VEHICLE-SMALL 200 380
                                                     (place-image FROG (/ SIZE 2) 500 SCENE)))))
(check-expect (draw-world world-check6)
              (place-image TURTLE-IMAGE 200 180
                           (place-image WOOD-IMAGE 200 180
                                        (place-image VEHICLE-SMALL 200 380
                                                     (place-image FROG-D (/ SIZE 2) 500 SCENE)))))
(check-expect (draw-world world-check7)
              (place-image TURTLE-IMAGE 200 180
                           (place-image WOOD-IMAGE 200 180
                                        (place-image VEHICLE-SMALL 200 380
                                                     (place-image FROG-R (/ SIZE 2) 500 SCENE)))))
(check-expect (draw-world world-check8)
              (place-image TURTLE-IMAGE 200 180
                           (place-image WOOD-IMAGE 200 180
                                        (place-image VEHICLE-SMALL 200 380
                                                     (place-image FROG-L (/ SIZE 2) 500 SCENE)))))

(define (draw-world aw)
  (local [(define v-x-pos (λ (i) (vehicle-x i)))
          (define v-y-pos (λ (i) (vehicle-y i)))
          (define w-x-pos (λ (i) (wood-x i)))
          (define w-y-pos (λ (i) (wood-y i)))
          (define t-x-pos (λ (i) (turtle-x i)))
          (define t-y-pos (λ (i) (turtle-y i)))
          
          ;draw-player : Player Image -> Image
          ;draws player as a Image while facing the according way
          ;(check-expect (draw-player player-init rest) (place-image FROG 400 500 rest))
          ;(check-expect (draw-player player-random rest) (place-image FROG-L 200 100 rest))
          (define (draw-player ap bg)
            (cond
              [(string=? (player-face ap) "left")
               (place-image FROG-L (player-x ap) (player-y ap) bg)]
              [(string=? (player-face ap) "right")
               (place-image FROG-R (player-x ap) (player-y ap) bg)]
              [(string=? (player-face ap) "up")
               (place-image FROG (player-x ap) (player-y ap) bg)]
              [(string=? (player-face ap) "down")
               (place-image FROG-D (player-x ap) (player-y ap) bg)]))
                                   
          ; draw-v/w/t: Vehicle/Wood/Turtle Image -> Image
          ; draws the vehicle or wood or turtle onto the scene
          ; creates an image using the position of the given vehicle or wood
          ; (check-expect  (draw-v veh-1-1 SCENE)  (place-image VEHICLE-SMALL 0 380 SCENE))
          ; (check-expect  (draw-v veh-1-2 SCENE)  (place-image VEHICLE-SMALL 200 380 SCENE))
          ; (check-expect  (draw-w wood-1 SCENE)   (place-image WOOD-IMAGE 0 180 SCENE))
          ; (check-expect  (draw-w wood-2 SCENE)   (place-image WOOD-IMAGE 200 180 SCENE))
          ; (check-expect  (draw-t turtle-1 SCENE) (place-image TURTLE-IMAGE 0 180 SCENE))
          ; (check-expect  (draw-t turtle-2 SCENE) (place-image TURTLE-IMAGE 200 180 SCENE))
          (define (draw-v/w/t v base)
            (cond [(vehicle? v) (place-image VEHICLE-SMALL (v-x-pos v) (v-y-pos v) base)]
                  [(wood? v)    (place-image WOOD-IMAGE (w-x-pos v) (w-y-pos v) base)]
                  [(turtle? v)  (place-image TURTLE-IMAGE (t-x-pos v) (t-y-pos v) base)]))]
    
    (draw-player (world-player aw)
                 (foldr draw-v/w/t
                        (foldr draw-v/w/t
                               (foldr draw-v/w/t
                                      SCENE
                                      (world-vehicles aw)) (world-woods aw)) (world-turtles aw)))))

; move-world: World -> World
; the vehicle will move left or right accordingly
; the wood will only move right, will reappear in opposite side of windoow if if leaves the screen
; the turtle will only move left, will reappear in opposite side of windoow if if leaves the screen

(check-expect (move-world world-check)
              (make-world player-init
                          (cons (make-vehicle 799 380 "left") '())
                          (cons (make-wood 1 180 "right") '())
                          (cons (make-turtle 799 180 "left") '())))
(check-expect (move-world world-check2)
              (make-world player-init
                          (cons (make-vehicle 199 380 "left") '())
                          (cons (make-wood 201 180 "right") '())
                          (cons (make-turtle 199 180 "left") '())))
(check-expect (move-world world-check3)
              (make-world player-init
                          (cons (make-vehicle 101 340 "right") '())
                          (cons (make-wood 101 140 "right") '())
                          (cons (make-turtle 99 240 "left") '())))
(check-expect (move-world world-check4)
              (make-world player-init
                          (cons (make-vehicle 1 340 "right") '())
                          (cons (make-wood 1 140 "right") '())
                          (cons (make-turtle 99 240 "left") '())))
(check-expect (move-world world-check5)
              (make-world player-init
                          (cons (make-vehicle 1 340 "right") '())
                          (cons (make-wood 1 140 "right") '())
                          (cons (make-turtle 99 240 "left") '())))
(check-expect (move-world world-check-w)
              (make-world (make-player 0 180 "up")
                          (cons (make-vehicle 799 380 "left") '())
                          (cons (make-wood 1 180 "right") '())
                          (cons (make-turtle 799 180 "left") '())))
(check-expect (move-world world-check3w)
              (make-world (make-player 101 140 "up")
                          (cons (make-vehicle 101 340 "right") '())
                          (cons (make-wood 101 140 "right") '())
                          (cons (make-turtle  99 240 "left") '()))) 
     
(define (move-world aw)
  (local [(define    w-right (λ (aw)  (+ (wood-x aw) 40)))
          (define     w-left (λ (aw)  (- (wood-x aw) 40)))
          (define      w-top (λ (aw)  (- (wood-y aw) 20)))
          (define    t-right (λ (aw)  (+ (turtle-x aw) 40)))
          (define     t-left (λ (aw)  (- (turtle-x aw) 40)))
          (define      t-top (λ (aw)  (- (turtle-y aw) 20)))
          (define  circl-abs (λ (ap op ep) (op (ep ap) 20)))
          (define  circ-xmin (λ (ap)  (circl-abs ap - player-x)))
          (define  circ-xmax (λ (ap)  (circl-abs ap + player-x)))
          (define  circ-ymin (λ (ap)  (circl-abs ap - player-y)))
          (define     dleft? (λ (dir) (string=? "left"  dir)))
          (define    dright? (λ (dir) (string=? "right" dir)))
          
          ; veh-drawx-m: Vehicle or Wood -> Number 
          ; Takes in a Vehacle and outputs x position shifter by 1 according to direction
          ; (check-expect (veh-drawx-m veh-1-1) 799)
          ; (check-expect (veh-drawx-m veh-1-2) 199)
          ; (check-expect (veh-drawx-m veh-2-1) 101)
          ; (check-expect (veh-drawx-m veh-2-2) 301)
          ; (check-expect (veh-drawx-m (make-vehicle 800 160 "right")) 1)  
          (define (veh-drawx-m av)
            (cond [(vehicle? av)
                   (cond [(and (dleft?  (vehicle-dir av)) (= 0 (vehicle-x av))) 799]
                         [(and (dright? (vehicle-dir av)) (= 800 (vehicle-x av))) 1]
                         [(dleft?  (vehicle-dir av)) (sub1 (vehicle-x av))]
                         [(dright? (vehicle-dir av)) (add1 (vehicle-x av))])]
                  [(wood? av)   (if (= 800 (wood-x av))   1   (add1 (wood-x av)))]
                  [(turtle? av) (if (= 0   (turtle-x av)) 799 (sub1 (turtle-x av)))]))
          
          (define move-v (λ (v) (make-vehicle (veh-drawx-m v) (vehicle-y v) (vehicle-dir v))))
          (define move-w (λ (v) (make-wood    (veh-drawx-m v) (wood-y v)    (wood-dir v))))
          (define move-t (λ (v) (make-turtle  (veh-drawx-m v) (turtle-y v)  (turtle-dir v))))
          
          ; on-wood? : [Wood or Turtle] Player -> Boolean
          ; Give true if the player is on th wood or turtle
          ; (check-expect (on-wood? wood-1 player-init) #f)
          ; (check-expect (on-wood? wood-1 (make-player 0 180) #t))
          ; (check-expect (on-wood? turtle-1 (make-player 0 180) #t))
          ; (check-expect (on-wood? turtle-1 player-init) #f)
          (define (on-wood? w p)
            (cond [(wood? w) (and (or (< (w-left w) (circ-xmin p) (w-right w))
                                      (< (w-left w) (circ-xmax p) (w-right w)))
                                  (= (circ-ymin p) (w-top w)))]
                  [(turtle? w) (and (or (< (t-left w) (circ-xmin p) (t-right w))
                                        (< (t-left w) (circ-xmax p) (t-right w)))
                                    (= (circ-ymin p) (t-top w)))]))
          
          ;ride-wood : [Wood or Turtle] Player -> Player
          ;If Player is riding the wood, it will ride the wood
          ;(check-expect (ride-wood player-init) player-init)
          ;(check-expect (ride-wood (make-player ) player-init)
          (define (ride-wood w p)
            (cond [(and (on-wood? w p) (wood? w))   (make-player (add1 (player-x p))
                                                                 (player-y p)
                                                                 (player-face p))]
                  [(and (on-wood? w p) (turtle? w)) (make-player (sub1 (player-x p))
                                                                 (player-y p)
                                                                 (player-face p))]
                  [else p]))]
                  
    (make-world (foldr ride-wood (world-player aw) (append (world-woods aw) (world-turtles aw)))
                (map move-v (world-vehicles aw))
                (map move-w (world-woods aw))
                (map move-t (world-turtles aw)))))


;;move-player: World KeyEvent -> World
;;Each arrows on the key moves the player
(check-expect (move-player world-check "left") (make-world (make-player 360 500 "left")
                                                           vset-1
                                                           wset-1
                                                           tset-1))
(check-expect (move-player world-check "right") (make-world (make-player 440 500 "right")
                                                            vset-1
                                                            wset-1
                                                            tset-1))
(check-expect (move-player world-check "up") (make-world (make-player 400 460 "up")
                                                         vset-1
                                                         wset-1
                                                         tset-1))
(check-expect (move-player world-check "down") (make-world (make-player 400 540 "down")
                                                           vset-1
                                                           wset-1
                                                           tset-1))
(check-expect (move-player world-check "") world-check)

(define (move-player aw akey)
  (local [;;p-shift: Player KeyEvent -> Player
          ;;Shifts the player position depending on the key
          ; (check-expect (p-shift player-init  "left") (make-player 360 220))
          ; (check-expect (p-shift player-init "right") (make-player 440 220))
          ; (check-expect (p-shift player-init    "up") (make-player 400 180))
          ; (check-expect (p-shift player-init  "down") (make-player 400 260))
          ; (check-expect (p-shift player-init      "") player-init)
          (define (p-shift ap akey)
            (cond [(string=? akey "left") (make-player (- (player-x ap) 40) (player-y ap) akey)] 
                  [(string=? akey "right") (make-player (+ (player-x ap) 40) (player-y ap) akey)]
                  [(string=? akey "up") (make-player (player-x ap) (- (player-y ap) 40) akey)]
                  [(string=? akey "down") (make-player (player-x ap) (+ (player-y ap) 40) akey)]
                  [else ap]))]
    (make-world (p-shift (world-player aw) akey)
                (world-vehicles aw)
                (world-woods aw)
                (world-turtles aw))))

;;done?: World -> Boolean
;;Game is over when the player come in contact with a vehicle
(check-expect (done? world-check) #f)
(check-expect (done? (make-world (make-player 800 100 "up") vset-1 wset-1 tset-1)) #t)
(check-expect (done? (make-world (make-player 0 100 "down") vset-1 wset-1 tset-1)) #t)
(check-expect (done? (make-world (make-player 0 380 "right") vset-1 wset-1 tset-1)) #t)
(check-expect (done? (make-world player-init (list (make-vehicle 420 500 "left")) wset-1 tset-1)) #t)
(check-expect (done? (make-world (make-player 400 180 "up")
                                 (list (make-vehicle 420 420 "left"))
                                 (list (make-wood 470 180 "right"))
                                 (list (make-turtle 420 100 "left")))) #t)
(check-expect (done? (make-world (make-player 400 180 "up")
                                 (list (make-vehicle 420 420 "left"))
                                 (list (make-wood 400 180 "right"))
                                 (list (make-turtle 420 100 "left")))) #f)
(check-expect (done? (make-world (make-player 400 180 "up")
                                 (list (make-vehicle 420 420 "left"))
                                 (list (make-wood 400 180 "right"))
                                 (list (make-turtle 330 180 "left")))) #t) 

(define (done? aw)
  (local [(define ap (world-player aw))
          (define veh-right (λ (av) (+ (vehicle-x av) 40)))
          (define  veh-left (λ (av) (- (vehicle-x av) 40)))
          (define   veh-top (λ (av) (- (vehicle-y av) 20)))
          (define   w-right (λ (aw) (+ (wood-x aw) 40)))
          (define    w-left (λ (aw) (- (wood-x aw) 40)))
          (define     w-top (λ (aw) (- (wood-y aw) 20)))
          (define   t-right (λ (aw) (+ (turtle-x aw) 40)))
          (define    t-left (λ (aw) (- (turtle-x aw) 40)))
          (define     t-top (λ (aw) (- (turtle-y aw) 20)))
          (define circl-abs (λ (ap op ep) (op (ep ap) 20)))
          (define circ-xmin (λ (ap) (circl-abs ap - player-x)))
          (define circ-xmax (λ (ap) (circl-abs ap + player-x)))
          (define circ-ymin (λ (ap) (circl-abs ap - player-y)))
          
          ; overwrap?: Player Vehicle Wood -> Boolean
          ; Takes in Player and Vehicle and see if they overwrap
          ; (check-expect (overwrap? player-init veh-1-1) #f)
          ; (check-expect (overwrap? player-init (make-vehicle 380 220 "left")) #t)
          ; (check-expect (overwrap? player-init (make-vehicle 420 220 "left")) #t)
          ; (check-expect (overwrap? player-win  (make-vehicle 420 220 "left")) #t)
          ; (check-expect (overwrap? player-init (make-wood 380 200 "right")) #f)
          ; (check-epxect (overwrap? (make-player 400 180) (make-wood 470 180 "right")) #t)
          ; (check-expect (overwrap? (make-player 400 180) (make-wood 300 180 "right")) #t)
          (define (overwrap? obj)
            (cond [(vehicle? obj) (and (or (< (veh-left obj) (circ-xmin ap) (veh-right obj))
                                           (< (veh-left obj) (circ-xmax ap) (veh-right obj)))
                                       (= (circ-ymin ap) (veh-top obj)))]
                  [(wood? obj) (and (or (< (w-right obj)
                                           (circ-xmin ap)
                                           (+ (w-right obj) 120))
                                        (> (w-left obj)
                                           (circ-xmax ap)
                                           (- (w-left obj) 120)))
                                    (= (circ-ymin ap) (w-top obj)))]
                  [(turtle? obj) (and (or (< (t-right obj)
                                             (circ-xmin ap)
                                             (+ (t-right obj) 120))
                                          (> (t-left obj)
                                             (circ-xmax ap)
                                             (- (t-left obj) 120)))
                                      (= (circ-ymin ap) (t-top obj)))]))]
    (or (<= (player-y ap) 20)
        (ormap overwrap? (world-vehicles aw))
        (ormap overwrap? (world-woods aw))
        (ormap overwrap? (world-turtles aw))
        (< (circ-xmin ap) 0)
        (> (circ-xmax ap) 800))))