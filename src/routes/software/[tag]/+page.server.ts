export const load = async({ url, parent })=> {
  const { searchParams } = url
  const { tag } = await parent()
  return {
    tag,
    keyword: searchParams.get('keyword') || ''
  }
}