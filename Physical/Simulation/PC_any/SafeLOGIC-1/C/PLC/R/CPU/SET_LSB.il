. a s s e m b l y   e x t e r n   m s c o r l i b   {   }  
 . a s s e m b l y   e x t e r n   _ _ F i e l d A t t r i b u t e   {   }  
 . a s s e m b l y   S E T _ L S B   {   }  
 . m o d u l e   S E T _ L S B . d l l  
  
 . c l a s s   p r i v a t e   a u t o   a n s i   b e f o r e f i e l d i n i t   S E T _ L S B  
               e x t e n d s   [ m s c o r l i b ] S y s t e m . O b j e c t  
 {  
     . f i e l d   p u b l i c   s t a t i c   u n s i g n e d   i n t 1 6   _ _ C O N S T _ W O R D _ 6 5 2 8 0  
     . c u s t o m   i n s t a n c e   v o i d   [ _ _ F i e l d A t t r i b u t e ] _ _ F i e l d A t t r i b u t e : : . c t o r ( v a l u e t y p e   [ _ _ F i e l d A t t r i b u t e ] F i e l d T y p e ,  
                                                                                                                                     i n t 3 2 ,  
                                                                                                                                     i n t 3 2 ,  
                                                                                                                                     i n t 3 2 ,  
                                                                                                                                     b o o l )   =   (   0 1   0 0   0 A   0 0   0 0   0 0   0 0   F F   0 0   0 0   0 0   0 0   0 0   0 0   0 0   0 0    
                                                                                                                                                         0 0   0 0   0 0   0 0   0 0   )    
     . m e t h o d   p u b l i c   h i d e b y s i g   s p e c i a l n a m e   r t s p e c i a l n a m e    
                     i n s t a n c e   v o i d     . c t o r ( )   c i l   m a n a g e d  
     {  
         / /   C o d e   s i z e               1 7   ( 0 x 1 1 )  
         . m a x s t a c k     8  
         I L _ 0 0 0 0 :     l d a r g . 0  
         I L _ 0 0 0 1 :     c a l l               i n s t a n c e   v o i d   [ m s c o r l i b ] S y s t e m . O b j e c t : : . c t o r ( )  
         I L _ 0 0 0 6 :     l d c . i 4           0 x f f 0 0  
         I L _ 0 0 0 b :     s t s f l d           u n s i g n e d   i n t 1 6   S E T _ L S B : : _ _ C O N S T _ W O R D _ 6 5 2 8 0  
         I L _ 0 0 1 0 :     r e t  
     }   / /   e n d   o f   m e t h o d   S E T _ L S B : : . c t o r  
  
     . m e t h o d   p u b l i c   h i d e b y s i g   s t a t i c   u n s i g n e d   i n t 1 6    
                     _ _ S E T _ L S B ( u n s i g n e d   i n t 8   L S B ,  
                                         u n s i g n e d   i n t 1 6   D A T A )   c i l   m a n a g e d  
     {  
         / /   C o d e   s i z e               8   ( 0 x 8 )  
         . m a x s t a c k     8  
         I L _ 0 0 0 0 :     l d a r g . 1  
         I L _ 0 0 0 1 :     l d s f l d           u n s i g n e d   i n t 1 6   S E T _ L S B : : _ _ C O N S T _ W O R D _ 6 5 2 8 0  
         I L _ 0 0 0 3 :     a n d  
         I L _ 0 0 0 4 :     l d a r g . 0  
         I L _ 0 0 0 5 :     c o n v . u 2  
         I L _ 0 0 0 6 :     o r  
         I L _ 0 0 0 7 :     r e t  
     }   / /   e n d   o f   m e t h o d   S E T _ L S B : : _ _ S E T _ L S B  
  
 }   / /   e n d   o f   c l a s s   S E T _ L S B  
 