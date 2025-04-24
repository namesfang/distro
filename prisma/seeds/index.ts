import { PrismaClient } from "../../src/generated/prisma"

const prisma = new PrismaClient()

async function main() {
  const pieces = await Promise.all([
    // 初始基础数据 - 软件芯片架构
    prisma.chip.createMany({
      data: [
        {id: 1, name: 'X86', disabled: false},
        {id: 2, name: 'ARM', disabled: false},
        {id: 3, name: 'LoongArch', disabled: false},
        {id: 4, name: 'MIPS', disabled: false},
      ]
    }),
    // 初始基础数据 - 软件包格式
    prisma.format.createMany({
      data: [
        {id: 1, name: 'deb', disabled: false},
        {id: 2, name: 'rpm', disabled: false},
        {id: 3, name: 'AppImage', disabled: false},
      ]
    }),
    // 初始基础数据 - 软件包所属标签
    prisma.tag.createMany({
      data: [
        {id: 1, icon: 'folder-image', href: '/software/image', label: '图片', disabled: false},
        {id: 2, icon: 'folder-music', href: '/software/music', label: '音乐', disabled: false},
        {id: 3, icon: 'folder-video', href: '/software/video', label: '视频', disabled: false},
        {id: 4, icon: 'gamepad', href: '/software/game', label: '游戏', disabled: false},
        {id: 5, icon: 'message-3', href: '/software/chat', label: '聊天', disabled: false},
        {id: 6, icon: 'global', href: '/software/net', label: '网络', disabled: false},
        {id: 7, icon: 'shield-cross', href: '/software/security', label: '安全', disabled: false},
        {id: 8, icon: 'movie-2', href: '/software/cut', label: '剪辑', disabled: false},
        {id: 9, icon: 'code-box', href: '/software/dev', label: '编程', disabled: false},
        {id: 10, icon: 'briefcase', href: '/software/office', label: '办公', disabled: false},
        {id: 11, icon: 'function-add', href: '/software/desktop', label: '桌面', disabled: false},
        {id: 12, icon: 'cpu', href: '/software/device', label: '驱动', disabled: false},
        {id: 13, icon: 'computer', href: '/software/system', label: '系统', disabled: false},
        {id: 14, icon: 'keyboard-box', href: '/software/input', label: '输入法', disabled: false},
        {id: 15, icon: 'chrome', href: '/software/browser', label: '浏览器', disabled: false},
        {id: 16, icon: 'funds-box', href: '/software/finance', label: '股票网银', disabled: false},
        {id: 17, icon: 'inbox-unarchive', href: '/software/burn', label: '解压刻录', disabled: false},
      ]
    }),
  ])

  console.log(pieces)
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error("eeee", e)
    await prisma.$disconnect()
    process.exit(1)
  })