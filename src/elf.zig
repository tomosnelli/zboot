pub const ElfHeader = struct {
    // 0x00
    //  4bytes should be 0x7F 0x45 0x4C 0x46
    magic: [4]u8,

    // 0x04 32 or 64 bits
    // 1 -> 32, 2 -> 64
    class: u8,

    // 0x05 endianness
    // 1 -> little, 2 -> big
    endian: u8,

    // 0x06 set to 1 for the original and current version of ELF?
    ei_version: u8,

    // 0x07 operating system ABI
    ei_osabi: u8,

    // 0x08 abi version
    ei_abiversion: u8,

    // 0x09 padding UNUSED
    ei_pad: [7]u8,

    // 0x10 object file type
    e_type: [2]u8,

    // 0x12 specify target instruction set architecture
    e_machine: [2]u8,

    // 0x14 set to 1 for the original version of ELF
    e_version: [4]u8,

    // 0x18 memory address of the entry point
    e_entry: [8]u8,

    // 0x20 address that points to the start of the program header table.
    e_phoff: [8]u8,

    // 0x28 address that points to the start of the section header table
    e_shoff: [8]u8,

    // 0x30 interpretation of this field depends on the target architecture
    e_flags: [4]u8,

    // 0x34 size of this elf header. Usually 64 bytes for 64 bit and 52 bytes for 32 bit
    e_ehsize: [2]u8,

    // 0x36 contains the size of a program header table entry
    e_phentsize: [2]u8,

    // 0x38 contains the number of entries in the program header table.
    e_phnum: [2]u8,

    // 0x3A contains the size of a section header table entry.
    e_shentsize: [2]u8,

    // 0x3C contains the number of entries in the section header table.
    e_shnum: [2]u8,

    // 0x3E contains index of the section header table entry that contains the section names
    e_shstrndx: [2]u8,

    // 0x40 end of elf header
};

pub const ProgramHeader = struct {
    // 0x00 indentifies the type of the segment
    p_type: [4]u8,

    // 0x04 segment dependent flags (position for 64 bit struct)
    p_flags: [4]u8,

    // 0x08 offset of the segment in the file image
    p_offset: [8]u8,

    // 0x10 virtual address of the segment in memory
    p_vaddr: [8]u8,

    // 0x18 on systems where physical address is relevant, reserved for segments physical address
    p_paddr: [8]u8,

    // 0x20 size in bytes of the segment in the file image
    p_filesz: [8]u8,

    // 0x28 size in bytes of the segment in memory.
    p_memsz: [8]u8,

    // 0x30 0 and 1 specify no alignment. Otherwise should be a positive, integral power of 2
    p_align: [8]u8,
};

pub const SectionHeader = struct {
    // 0x00 offset to a string in the .shstrtab section that represents the name of this section
    sh_name: [4]u8,

    // 0x04 identifies the type of this header
    sh_type: [4]u8,

    //0x08 identifies the attributes of the section
    sh_flags: [8]u8,

    // 0x10 virtual address of the sectio in memory, for sections that are loaded
    sh_addr: [8]u8,

    // 0x18 offset of the section in the file iamge
    sh_offset: [8]u8,

    // 0x20 size in bytes of the section
    sh_size: [8]u8,

    // 0x28 contains the section index of an associated section.
    // This field is used for several purposes, depending on the type of section
    sh_link: [4]u8,

    // 0x2C contains extra infor about the section. This field is used for several purposes
    // depending on the type of section
    sh_info: [4]u8,

    // 0x30 Contains the required alignment of the section. This field must be a power of two
    sh_addralign: [8]u8,

    // 0x38 Contains the size, in bytes, of each entry, for sections that contain fixed-size entries.
    sh_entsize: [8]u8,

    // End of section header 0x40
};
