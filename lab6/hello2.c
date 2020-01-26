/*  hello2.c - Hello World kernel module (now with parameters!)
 *  
 *  Demonstrates module initialization, module release and printk.
 *
 *  (Adapted from various example modules including those found in the
 *  Linux Kernel Programming Guide, Linux Device Drivers book and
 *  FSM's device driver tutorial)
 */

#include <linux/module.h>  /* Needed by all modules */
#include <linux/moduleparam.h>  /* Needed for module parameters */
#include <linux/kernel.h>  /* Needed for printk and KERN_* */
#include <linux/init.h>	   /* Need for __init macros  */

/* Each of these stanzas defines a module parameter.  Note the global
   static variable for each.  It is also possible to do comma
   separated arrays.*/
static int my_int = 10;
module_param(my_int, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
MODULE_PARM_DESC(my_int, "An init parameter");

static char * my_string = "My default String!\n";
module_param(my_string, charp, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
MODULE_PARM_DESC(my_string, "An init string");


/* This function is run upon module load. This is where you setup data
   structures and reserve resources used by the module. */
static int __init my_init(void)
{
  /* printk's to show what the param strings are */
  printk(KERN_INFO "Hello world\n");
  printk(KERN_INFO "my_int = %d\n", my_int);
  printk(KERN_INFO "my_string = %s", my_string);
  
  // A non 0 return means init_module failed; module can't be loaded.
  return 0;
}


/* This function is run just prior to the module's removal from the
   system.  You should release _ALL_ resources used by your module
   here (otherwise be prepared for a reboot). */
static void __exit my_exit(void)
{
  printk(KERN_ALERT "Goodbye world 1.\n");
  printk(KERN_INFO "my_int = %d\n", my_int);
  printk(KERN_INFO "my_string = %s", my_string);
}  


/* These define info that can be displayed by modinfo */
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Paul V. Gratz (and others)");
MODULE_DESCRIPTION("Simple Hello World Module");

/* Here we define which functions we want to use for initialization
   and cleanup */
module_init(my_init);
module_exit(my_exit);
