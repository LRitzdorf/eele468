// Linux Platform Device Driver for the ADC Controller for DE-Series Boards component

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/mod_devicetable.h>
#include <linux/types.h>
#include <linux/io.h>
#include <linux/mutex.h>
#include <linux/miscdevice.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/uaccess.h>

//-----------------------------------------------------------------------
// Register Offsets
//-----------------------------------------------------------------------
// Define individual register offsets
#define REG_DELAYM_OFFSET 0x0
#define REG_B0_OFFSET 0x4
#define REG_BM_OFFSET 0x8
#define REG_WETDRYMIX_OFFSET 0xC
// Memory span of all registers (used or not) in the component
#define SPAN 0x10


//-----------------------------------------------------------------------
// ADC Controller device structure
//-----------------------------------------------------------------------
/**
 * struct comb_filter_dev - Private comb_filter device struct.
 * @miscdev: miscdevice used to create a char device for the comb_filter
 *           component
 * @base_addr: Base address of the comb_filter component
 * @lock: mutex used to prevent concurrent writes to the comb_filter component
 *
 * An comb_filter struct gets created for each comb_filter component in the
 * system.
 */
struct comb_filter_dev {
    struct miscdevice miscdev;
    void __iomem *base_addr;
    struct mutex lock;
};


//-----------------------------------------------------------------------
// REG0: DelayM parameter (RW)
//-----------------------------------------------------------------------

/**
 * delaym_show() - Report the comb filter's delay parameter to userspace.
 * @dev: Device structure for the comb_filter component. This device struct is
 *       embedded in the comb_filter's platform device struct.
 * @attr: Unused.
 * @buf: Output buffer, passed to userspace.
 *
 * Return: The number of bytes read.
 */
static ssize_t delaym_show(struct device *dev, struct device_attribute *attr,
        char *buf)
{
    struct comb_filter_dev *priv = dev_get_drvdata(dev);
    u32 delaym = ioread32(priv->base_addr + REG_DELAYM_OFFSET);
    return scnprintf(buf, PAGE_SIZE, "%u\n", delaym);
}

/**
 * delaym_store() - Set the comb filter's delay parameter from userspace.
 * @dev: Device structure for the comb_filter component. This device struct is
 *       embedded in the comb_filter's platform device struct.
 * @attr: Unused.
 * @buf: Input buffer, passed from userspace.
 * @size: The number of bytes being written. Unused.
 *
 * Return: The number of bytes stored. Always equal to number of bytes written.
 */
static ssize_t delaym_store(struct device *dev, struct device_attribute *attr,
        const char *buf, size_t size)
{
    struct comb_filter_dev *priv = dev_get_drvdata(dev);
    // Parse the string we received as a u16
    u16 delaym;
    int ret = kstrtou16(buf, 0, &delaym);
    if (ret < 0) {
        return ret;
    }
    // Write the resulting value, and return the number of bytes we "wrote"
    iowrite32(delaym, priv->base_addr + REG_DELAYM_OFFSET);
    return size;
}


//-----------------------------------------------------------------------
// REG1: b0 parameter (RW)
//-----------------------------------------------------------------------

/**
 * b0_show() - Report the comb filter's b0 parameter to userspace.
 * @dev: Device structure for the comb_filter component. This device struct is
 *       embedded in the comb_filter's platform device struct.
 * @attr: Unused.
 * @buf: Output buffer, passed to userspace.
 *
 * Return: The number of bytes read.
 */
static ssize_t b0_show(struct device *dev, struct device_attribute *attr,
        char *buf)
{
    struct comb_filter_dev *priv = dev_get_drvdata(dev);
    s32 b0 = ioread32(priv->base_addr + REG_B0_OFFSET);
    return scnprintf(buf, PAGE_SIZE, "%d\n", b0);
}

/**
 * b0_store() - Set the comb filter's b0 parameter from userspace.
 * @dev: Device structure for the comb_filter component. This device struct is
 *       embedded in the comb_filter's platform device struct.
 * @attr: Unused.
 * @buf: Input buffer, passed from userspace.
 * @size: The number of bytes being written. Unused.
 *
 * Return: The number of bytes stored. Always equal to number of bytes written.
 */
static ssize_t b0_store(struct device *dev, struct device_attribute *attr,
        const char *buf, size_t size)
{
    struct comb_filter_dev *priv = dev_get_drvdata(dev);
    // Parse the string we received as a s16
    s16 b0;
    int ret = kstrtos16(buf, 0, &b0);
    if (ret < 0) {
        return ret;
    }
    // Write the resulting value, and return the number of bytes we "wrote"
    iowrite32(b0, priv->base_addr + REG_B0_OFFSET);
    return size;
}


//-----------------------------------------------------------------------
// REG2: bM parameter (RW)
//-----------------------------------------------------------------------

/**
 * bm_show() - Report the comb filter's bM parameter to userspace.
 * @dev: Device structure for the comb_filter component. This device struct is
 *       embedded in the comb_filter's platform device struct.
 * @attr: Unused.
 * @buf: Output buffer, passed to userspace.
 *
 * Return: The number of bytes read.
 */
static ssize_t bm_show(struct device *dev, struct device_attribute *attr,
        char *buf)
{
    struct comb_filter_dev *priv = dev_get_drvdata(dev);
    s32 bm = ioread32(priv->base_addr + REG_BM_OFFSET);
    return scnprintf(buf, PAGE_SIZE, "%d\n", bm);
}

/**
 * bm_store() - Set the comb filter's bM parameter from userspace.
 * @dev: Device structure for the comb_filter component. This device struct is
 *       embedded in the comb_filter's platform device struct.
 * @attr: Unused.
 * @buf: Input buffer, passed from userspace.
 * @size: The number of bytes being written. Unused.
 *
 * Return: The number of bytes stored. Always equal to number of bytes written.
 */
static ssize_t bm_store(struct device *dev, struct device_attribute *attr,
        const char *buf, size_t size)
{
    struct comb_filter_dev *priv = dev_get_drvdata(dev);
    // Parse the string we received as a s16
    s16 bm;
    int ret = kstrtos16(buf, 0, &bm);
    if (ret < 0) {
        return ret;
    }
    // Write the resulting value, and return the number of bytes we "wrote"
    iowrite32(bm, priv->base_addr + REG_BM_OFFSET);
    return size;
}


//-----------------------------------------------------------------------
// REG3: WetDryMix parameter (RW)
//-----------------------------------------------------------------------

/**
 * wetdrymix_show() - Report the comb filter's WetDryMix parameter to userspace.
 * @dev: Device structure for the comb_filter component. This device struct is
 *       embedded in the comb_filter's platform device struct.
 * @attr: Unused.
 * @buf: Output buffer, passed to userspace.
 *
 * Return: The number of bytes read.
 */
static ssize_t wetdrymix_show(struct device *dev, struct device_attribute *attr,
        char *buf)
{
    struct comb_filter_dev *priv = dev_get_drvdata(dev);
    u32 wetdrymix = ioread32(priv->base_addr + REG_WETDRYMIX_OFFSET);
    return scnprintf(buf, PAGE_SIZE, "%u\n", wetdrymix);
}

/**
 * wetdrymix_store() - Set the comb filter's WetDryMix parameter from userspace.
 * @dev: Device structure for the comb_filter component. This device struct is
 *       embedded in the comb_filter's platform device struct.
 * @attr: Unused.
 * @buf: Input buffer, passed from userspace.
 * @size: The number of bytes being written. Unused.
 *
 * Return: The number of bytes stored. Always equal to number of bytes written.
 */
static ssize_t wetdrymix_store(struct device *dev, struct device_attribute *attr,
        const char *buf, size_t size)
{
    struct comb_filter_dev *priv = dev_get_drvdata(dev);
    // Parse the string we received as a u16
    u16 wetdrymix;
    int ret = kstrtou16(buf, 0, &wetdrymix);
    if (ret < 0) {
        return ret;
    }
    // Write the resulting value, and return the number of bytes we "wrote"
    iowrite32(wetdrymix, priv->base_addr + REG_WETDRYMIX_OFFSET);
    return size;
}


//-----------------------------------------------------------------------
// sysfs Attributes
//-----------------------------------------------------------------------
// Define sysfs attributes
static DEVICE_ATTR_RW(delaym);
static DEVICE_ATTR_RW(b0);
static DEVICE_ATTR_RW(bm);
static DEVICE_ATTR_RW(wetdrymix);

// Create an attribute group so the device core can export the attributes for
// us.
static struct attribute *comb_filter_attrs[] = {
    &dev_attr_delaym.attr,
    &dev_attr_b0.attr,
    &dev_attr_bm.attr,
    &dev_attr_wetdrymix.attr,
    NULL,
};
ATTRIBUTE_GROUPS(comb_filter);


//-----------------------------------------------------------------------
// File Operations read()
//-----------------------------------------------------------------------
/**
 * comb_filter_read() - Read method for the comb_filter char device
 * @file: Pointer to the char device file struct.
 * @buf: User-space buffer to read the value into.
 * @count: The number of bytes being requested.
 * @offset: The byte offset in the file being read from.
 *
 * Return: On success, the number of bytes written is returned and the offset
 *         @offset is advanced by this number. On error, a negative error value
 *         is returned.
 */
static ssize_t comb_filter_read(struct file *file, char __user *buf,
    size_t count, loff_t *offset)
{
    size_t ret;
    u32 val;

    loff_t pos = *offset;

    /* Get the device's private data from the file struct's private_data field.
     * The private_data field is equal to the miscdev field in the
     * comb_filter_dev struct. container_of returns the comb_filter_dev struct
     * that contains the miscdev in private_data.
     */
    struct comb_filter_dev *priv = container_of(file->private_data,
            struct comb_filter_dev, miscdev);

    // Check file offset to make sure we are reading to a valid location.
    if (pos < 0) {
        // We can't read from a negative file position.
        return -EINVAL;
    }
    if (pos >= SPAN) {
        // We can't read from a position past the end of our device.
        return 0;
    }
    if ((pos % 0x4) != 0) {
        /* Prevent unaligned access. Even though the hardware technically
         * supports unaligned access, we want to ensure that we only access
         * 32-bit-aligned addresses because our registers are 32-bit-aligned.
         */
        pr_warn("comb_filter_read: unaligned access\n");
        return -EFAULT;
    }

    // If the user didn't request any bytes, don't return any bytes :)
    if (count == 0) {
        return 0;
    }

    // Read the value at offset pos.
    val = ioread32(priv->base_addr + pos);

    ret = copy_to_user(buf, &val, sizeof(val));
    if (ret == sizeof(val)) {
        // Nothing was copied to the user.
        pr_warn("comb_filter_read: nothing copied\n");
        return -EFAULT;
    }

    // Increment the file offset by the number of bytes we read.
    *offset = pos + sizeof(val);

    return sizeof(val);
}

//-----------------------------------------------------------------------
// File Operations write()
//-----------------------------------------------------------------------
/**
 * comb_filter_write() - Write method for the comb_filter char device
 * @file: Pointer to the char device file struct.
 * @buf: User-space buffer to read the value from.
 * @count: The number of bytes being written.
 * @offset: The byte offset in the file being written to.
 *
 * Return: On success, the number of bytes written is returned and the offset
 *         @offset is advanced by this number. On error, a negative error value
 *         is returned.
 */
static ssize_t comb_filter_write(struct file *file, const char __user *buf,
        size_t count, loff_t *offset)
{
    size_t ret;
    u32 val;

    loff_t pos = *offset;

    /* Get the device's private data from the file struct's private_data field.
     * The private_data field is equal to the miscdev field in the
     * comb_filter_dev struct. container_of returns the comb_filter_dev
     * struct that contains the miscdev in private_data.
     */
    struct comb_filter_dev *priv = container_of(file->private_data,
            struct comb_filter_dev, miscdev);

    // Check file offset to make sure we are writing to a valid location.
    if (pos < 0) {
        // We can't write to a negative file position.
        return -EINVAL;
    }
    if (pos >= SPAN) {
        // We can't write to a position past the end of our device.
        return 0;
    }
    if ((pos % 0x4) != 0) {
        /* Prevent unaligned access. Even though the hardware technically
         * supports unaligned access, we want to ensure that we only access
         * 32-bit-aligned addresses because our registers are 32-bit-aligned.
         */
        pr_warn("comb_filter_write: unaligned access\n");
        return -EFAULT;
    }

    // If the user didn't request to write anything, return 0.
    if (count == 0) {
        return 0;
    }

    mutex_lock(&priv->lock);

    ret = copy_from_user(&val, buf, sizeof(val));
    if (ret == sizeof(val)) {
        // Nothing was copied from the user.
        pr_warn("comb_filter_write: nothing copied from user space\n");
        ret = -EFAULT;
        goto unlock;
    }

    // Write the value we were given at the address offset given by pos.
    iowrite32(val, priv->base_addr + pos);

    // Increment the file offset by the number of bytes we wrote.
    *offset = pos + sizeof(val);

    // Return the number of bytes we wrote.
    ret = sizeof(val);

unlock:
    mutex_unlock(&priv->lock);
    return ret;
}

//-----------------------------------------------------------------------
// File Operations Supported
//-----------------------------------------------------------------------
/**
 * comb_filter_fops - File operations supported by the comb_filter driver
 * @owner: The comb_filter driver owns the file operations; this ensures that
 *         the driver can't be removed while the character device is still in
 *         use.
 * @read: The read function.
 * @write: The write function.
 * @llseek: We use the kernel's default_llseek() function; this allows users to
 *          change what position they are writing/reading to/from.
 */
static const struct file_operations comb_filter_fops = {
    .owner = THIS_MODULE,
    .read = comb_filter_read,
    .write = comb_filter_write,
    .llseek = default_llseek,
};


//-----------------------------------------------------------------------
// Platform Driver Probe (Initialization) Function
//-----------------------------------------------------------------------
/**
 * comb_filter_probe() - Initialize device when a match is found
 * @pdev: Platform device structure associated with our comb_filter device;
 *        pdev is automatically created by the driver core based upon our
 *        comb_filter device tree node.
 *
 * When a device that is compatible with this comb_filter driver is found, the
 * driver's probe function is called. This probe function gets called by the
 * kernel when an comb_filter device is found in the device tree.
 */
static int comb_filter_probe(struct platform_device *pdev)
{
    struct comb_filter_dev *priv;
    int ret;

    /* Allocate kernel memory for the comb_filter device and set it to 0.
     * GFP_KERNEL specifies that we are allocating normal kernel RAM; see the
     * kmalloc documentation for more info. The allocated memory is
     * automatically freed when the device is removed.
     */
    priv = devm_kzalloc(&pdev->dev, sizeof(struct comb_filter_dev), GFP_KERNEL);
    if (!priv) {
        pr_err("Failed to allocate kernel memory for comb_filter\n");
        return -ENOMEM;
    }

    /* Request and remap the device's memory region. Requesting the region
     * makes sure nobody else can use that memory. The memory is remapped into
     * the kernel's virtual address space becuase we don't have access to
     * physical memory locations.
     */
    priv->base_addr = devm_platform_ioremap_resource(pdev, 0);
    if (IS_ERR(priv->base_addr)) {
        pr_err("Failed to request/remap platform device resource (comb_filter)\n");
        return PTR_ERR(priv->base_addr);
    }

    // Initialize the misc device parameters
    priv->miscdev.minor = MISC_DYNAMIC_MINOR;
    priv->miscdev.name = "comb_filter";
    priv->miscdev.parent = &pdev->dev;
    priv->miscdev.groups = comb_filter_groups;

    // Register the misc device; this creates a char dev at /dev/comb_filter
    ret = misc_register(&priv->miscdev);
    if (ret) {
        pr_err("Failed to register misc device for comb_filter\n");
        return ret;
    }

    // Attach the comb_filter's private data to the platform device's struct.
    platform_set_drvdata(pdev, priv);

    pr_info("comb_filter probed successfully\n");
    return 0;
}

//-----------------------------------------------------------------------
// Platform Driver Remove Function
//-----------------------------------------------------------------------
/**
 * comb_filter_remove() - Remove an comb_filter device.
 * @pdev: Platform device structure associated with our comb_filter device.
 *
 * This function is called when an comb_filter devicee is removed or the driver
 * is removed.
 */
static int comb_filter_remove(struct platform_device *pdev)
{
    // Get the comb_filter's private data from the platform device.
    struct comb_filter_dev *priv = platform_get_drvdata(pdev);

    // Deregister the misc device and remove the /dev/comb_filter file.
    misc_deregister(&priv->miscdev);

    pr_info("comb_filter removed successfully\n");

    return 0;
}

//-----------------------------------------------------------------------
// Compatible Match String
//-----------------------------------------------------------------------
/* Define the compatible property used for matching devices to this driver,
 * then add our device id structure to the kernel's device table. For a device
 * to be matched with this driver, its device tree node must use the same
 * compatible string as defined here.
 */
static const struct of_device_id comb_filter_of_match[] = {
    // NOTE: This .compatible string must be identical to the .compatible
    // string in the Device Tree Node for comb_filter
    { .compatible = "lr,combfilter", },
    { }
};
MODULE_DEVICE_TABLE(of, comb_filter_of_match);

//-----------------------------------------------------------------------
// Platform Driver Structure
//-----------------------------------------------------------------------
/**
 * struct comb_filter_driver - Platform driver struct for the comb_filter
 *                             driver
 * @probe: Function that's called when a device is found
 * @remove: Function that's called when a device is removed
 * @driver.owner: Which module owns this driver
 * @driver.name: Name of the comb_filter driver
 * @driver.of_match_table: Device tree match table
 * @driver.dev_groups: comb_filter sysfs attribute group; this allows the
 *                     driver core to create the attribute(s) without race
 *                     conditions.
 */
static struct platform_driver comb_filter_driver = {
    .probe = comb_filter_probe,
    .remove = comb_filter_remove,
    .driver = {
        .owner = THIS_MODULE,
        .name = "comb_filter",
        .of_match_table = comb_filter_of_match,
        .dev_groups = comb_filter_groups,
    },
};

/* We don't need to do anything special in module init/exit. This macro
 * automatically handles module init/exit.
 */
module_platform_driver(comb_filter_driver);

MODULE_LICENSE("Dual MIT/GPL");
MODULE_AUTHOR("Lucas Ritzdorf");  // Adapted from Ross Snider and Trevor Vannoy's Echo Driver
MODULE_DESCRIPTION("Driver for comb filter audio processor");
MODULE_VERSION("1.0");
